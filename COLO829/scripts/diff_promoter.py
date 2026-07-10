import os
import sys
from bisect import bisect_right
from statsmodels.sandbox.stats.multicomp import multipletests
from multiprocessing import Pool
import time

refseq_to_chr = {
    "NC_000001.11": "chr1",
    "NC_000002.12": "chr2",
    "NC_000003.12": "chr3",
    "NC_000004.12": "chr4",
    "NC_000005.10": "chr5",
    "NC_000006.12": "chr6",
    "NC_000007.14": "chr7",
    "NC_000008.11": "chr8",
    "NC_000009.12": "chr9",
    "NC_000010.11": "chr10",
    "NC_000011.10": "chr11",
    "NC_000012.12": "chr12",
    "NC_000013.11": "chr13",
    "NC_000014.9":  "chr14",
    "NC_000015.10": "chr15",
    "NC_000016.10": "chr16",
    "NC_000017.11": "chr17",
    "NC_000018.10": "chr18",
    "NC_000019.10": "chr19",
    "NC_000020.11": "chr20",
    "NC_000021.9":  "chr21",
    "NC_000022.11": "chr22",
    "NC_000023.11": "chrX",
    "NC_000024.10": "chrY",
    "NC_012920.1":  "chrM",
    }

import numpy as np
import rpy2.robjects as robjects
from rpy2.robjects.packages import importr


def init_r_worker():
    global methylKit, stats, base
    methylKit = importr('methylKit')
    stats = importr('stats')
    base = importr('base')
    robjects.r("options(warn=-1, verbose=FALSE)")
    robjects.r("suppressMessages(suppressWarnings(TRUE))")


def calculate_region_p_value_with_methylkit(site_data):
    if not site_data or len(site_data) < 5:
        return 1.0
        
    site_data = sorted(site_data, key=lambda x: x[0])
    
    data_matrix = np.array(site_data, dtype=np.int64)
    positions = data_matrix[:, 0]
    n1, n2 = data_matrix[:, 1], data_matrix[:, 2]
    t1, t2 = data_matrix[:, 3], data_matrix[:, 4]
    
    n_ts = n1 - n2
    t_ts = t1 - t2
    
    valid_mask = (n1 >= 10) & (t1 >= 10) & (n2 >= 0) & (t2 >= 0) & \
                 (n_ts >= 0) & (t_ts >= 0) & (n1 < 100000) & (t1 < 100000)
    
    positions = positions[valid_mask]
    n1, n2, n_ts = n1[valid_mask], n2[valid_mask], n_ts[valid_mask]
    t1, t2, t_ts = t1[valid_mask], t2[valid_mask], t_ts[valid_mask]
    
    num_sites = int(np.sum(valid_mask))
    if num_sites < 5:
        return 1.0
    
    df_normal = robjects.DataFrame({
        'chr': base.as_character(robjects.StrVector(['chr_target'] * num_sites)),
        'start': robjects.IntVector(positions.tolist()),
        'end': robjects.IntVector(positions.tolist()),
        'strand': robjects.StrVector(['*'] * num_sites),
        'coverage': robjects.IntVector(n1.tolist()),
        'numCs': robjects.IntVector(n2.tolist()),
        'numTs': robjects.IntVector(n_ts.tolist())
    })
    
    df_tumor = robjects.DataFrame({
        'chr': base.as_character(robjects.StrVector(['chr_target'] * num_sites)),
        'start': robjects.IntVector(positions.tolist()),
        'end': robjects.IntVector(positions.tolist()),
        'strand': robjects.StrVector(['*'] * num_sites),
        'coverage': robjects.IntVector(t1.tolist()),
        'numCs': robjects.IntVector(t2.tolist()),
        'numTs': robjects.IntVector(t_ts.tolist())
    })
    
    kwargs_normal = {'.Data': df_normal, 'sample.id': 'Normal', 'assembly': 'hg38', 'context': 'CpG', 'resolution': 'base'}
    meth_normal = robjects.r['new']("methylRaw", **kwargs_normal)
    
    kwargs_tumor = {'.Data': df_tumor, 'sample.id': 'Tumor', 'assembly': 'hg38', 'context': 'CpG', 'resolution': 'base'}
    meth_tumor = robjects.r['new']("methylRaw", **kwargs_tumor)
    
    meth_list = robjects.r['new'](
        "methylRawList", 
        robjects.ListVector({'Normal': meth_normal, 'Tumor': meth_tumor}), 
        treatment=robjects.IntVector([0, 1])
    )
    
    meth_base = methylKit.unite(meth_list, destrand=False)
    
    try:
        diff_meth = methylKit.calculateDiffMeth(meth_base, **{'num.cores': 1})
        p_values = diff_meth.rx2('pvalue')
        p_array = np.array(p_values)
        
        if len(p_array) == 0:
            return 1.0
            
        p_array = np.nan_to_num(p_array, nan=1.0)
        p_array = np.clip(p_array, 1e-300, 1.0)
        
        log_p_sum = sum(np.log(p_array))
        chi_stat = float(abs(-2 * log_p_sum))
        
        adjusted_df = float(max(2.0, 2 * np.sqrt(num_sites)))
        
        combined_p = stats.pchisq(chi_stat, df=adjusted_df, lower_tail=False)[0]
        return combined_p
        
    except Exception as e:
        return 1.0



def extract_promoter(gtf_file):
    promoter = dict()

    with open(gtf_file) as f:
        for line in f:
            if line.startswith("#"):
                continue

            chrom, cls, feature, start, end, _, strand, _, attrs = line.rstrip().split("\t")

            if chrom not in refseq_to_chr:
                continue
            else:
                chrom = refseq_to_chr[chrom]

            if feature != "transcript":
                continue

            if cls != "BestRefSeq":
                continue

            gene = attrs.split('gene "')[1].split('"')[0]

            start, end = int(start), int(end)

            if strand == "+":
                p_start, p_end = max(1, start - 2000), start
            else:
                p_start, p_end = end, end + 2000

            if chrom not in promoter:
                promoter[chrom] = dict()

            promoter[chrom][gene] = (p_start, p_end)

    return promoter


def preprocess_promoter(promoter):
    processed_promoter = dict()
    for chrom, values in promoter.items():
        genes = [(start, end, gene) for gene, (start, end) in values.items()]
        genes.sort(key=lambda x: x[0])
        starts = [x[0] for x in genes]
        processed_promoter[chrom] = (starts, genes)

    return processed_promoter


def get_mqi_bool(filename) -> dict:
    #print(f"Reading {filename}")
    bool_dict = dict()
    linecount = 0
    with open(filename, 'r') as f:
        for line in f:
            if linecount == 0:
                linecount += 1
                continue
            m = (line.strip()).split()
            if m[0] not in bool_dict:
                bool_dict[m[0]] = dict()
            if m[-1] == "PASS":
                b = True
            else:
                b = False
            
            bool_dict[m[0]][int(m[1])] = b


    return bool_dict


def find_gene(pos, starts, genes):
    idx = bisect_right(starts, pos) - 1

    if idx >= 0:
        start, end, gene = genes[idx]
        if start <= pos <= end:
            return gene

    return None



def classify_promoter(dms_file, processed_promoter, tumor_bool, normal_bool):
    gene = dict()
    qual = dict()

    with open(dms_file, 'r') as f:
        for line in f:
            m = (line.strip()).split()
            chrom = m[0]
            if chrom not in processed_promoter:
                continue
            pos = int(m[1])

            fit_gene = find_gene(pos, processed_promoter[m[0]][0], processed_promoter[m[0]][1])
            if fit_gene is not None:
                if fit_gene not in gene:
                    gene[fit_gene] = []
                if fit_gene not in qual:
                    qual[fit_gene] = [0, 0]                


                n1, n2 = int(m[7]), int(m[6].split(':')[-1])
                t1, t2 = int(m[9]), int(m[8].split(':')[-1])

                gene[fit_gene].append((pos, n1, n2, t1, t2))
                if tumor_bool[chrom][pos] and normal_bool[chrom][pos]:
                    qual[fit_gene][0] += 1
                qual[fit_gene][1] += 1

    gene_p = process_promoters(gene)
    gene_es = cal_effect_size(gene)

    final_qual = dict()
    for k, v in qual.items():
        final_qual[k] = v[0] / v[1]

    pass_genes, all_genes = set(), set()
    for g in gene_p:
        if g in gene_es:
            if gene_es[g][0] > 0.25:
                if g in gene_p:
                    if gene_p[g][1] < 0.05:
                        if g in final_qual:
                            if final_qual[g] > 0.7:
                                pass_genes.add(g)
                            all_genes.add(g)
            
    return pass_genes, all_genes


def process_promoters(indict):
    genes = list()
    sites_info = list()
    for k, v in indict.items():
        if len(v) >= 5:
            genes.append(k)
            sites_info.append(v)

    with Pool(32, initializer=init_r_worker) as p:
        p_values = p.map(calculate_region_p_value_with_methylkit, sites_info)

    temp_dict = {i: j for i, j in zip(genes, p_values)}
    corrected = correct_pvalues_fdr(temp_dict)
    return corrected


def cal_effect_size(indict):
    es = dict()
    for k, v in indict.items():
        t = 0
        if len(v) >= 5:
            L = len(v)
            for pos, n1, n2, t1, t2 in v:
                normal_ratio = n2 / n1 if n1 > 0 else 0
                tumor_ratio = t2 / t1 if t1 > 0 else 0
                t += (normal_ratio - tumor_ratio)
            es[k] = (t / L, L)

    return es



from statsmodels.stats.multitest import multipletests

def correct_pvalues_fdr(gene_dict, method='fdr_bh', alpha=0.05):
    if not gene_dict:
        return {}

    gene_ids = list(gene_dict.keys())
    p_values = list(gene_dict.values())

    reject_array, pvals_corrected, _, _ = multipletests(p_values, alpha=alpha, method=method)

    result_dict = {
        gene_id: (p_val, fdr_val) 
        for gene_id, p_val, fdr_val in zip(gene_ids, p_values, pvals_corrected)
    }

    return result_dict


def write_output(gene_p, gene_es, final_qual, output_file):
    with open(output_file, 'w') as f:
        f.write("gene\tcount\teffect_size\traw_p\tbh_p\tmqi")
        f.write('\n')
        for gene in gene_p:
            if gene in gene_es and gene in final_qual:
                f.write(f"{gene}\t{gene_es[gene][1]}\t{gene_es[gene][0]}\t{gene_p[gene][0]}\t{gene_p[gene][1]}\t{final_qual[gene]}")
                f.write('\n')
            
    print(f"Output {output_file} successful")


def write_txt(inset, output):
    with open(output, 'w') as f:
        for i in inset:
            f.write(str(i))
            f.write('\n')
    print(f"{output} output completed")


if __name__ == "__main__":
    start_time = time.time()
    tumor_idx = int(sys.argv[1])
    normal_idx = int(sys.argv[2])

    print("Extracting promoter region from GTF file")
    promoter = extract_promoter("../ref/GCF_000001405.40_GRCh38.p14_genomic.gtf")

    print("Preprocessing promoter region")
    processed_promoter = preprocess_promoter(promoter)

    print("Reading tumor MethQC results")
    tumor_bool = get_mqi_bool(f"../results/methqc_bed/COLO829_{tumor_idx}.bed")

    print("Reading normal MethQC results")
    normal_bool = get_mqi_bool(f"../results/methqc_bed/COLO829BL_{normal_idx}.bed")

    print("Classifying promoter")
    pass_genes, all_genes = classify_promoter(f"../results/ont_dms/COLO{tumor_idx}_COLOBL{normal_idx}_dms.bed", processed_promoter, tumor_bool, normal_bool)


    write_txt(pass_genes, f"../diff_promoter/pass_tumor{tumor_idx}_normal{normal_idx}.txt")
    write_txt(all_genes, f"../diff_promoter/all_tumor{tumor_idx}_normal{normal_idx}.txt")

    end_time = time.time()
    print(f"Total processing time: {end_time - start_time}")



