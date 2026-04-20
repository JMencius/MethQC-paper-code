import os
import sys
import pysam
import re
import numpy as np

SUBJECT = set([f"chr{i}" for i in range(1, 23)] + ["chrX", "chrY"])
ALL_CHR = [f"chr{i}" for i in range(1, 23)] + ["chrX", "chrY"]


def get_cpg_c_positions(fasta_path, chrom):
    fasta = pysam.FastaFile(fasta_path)
    seq = fasta.fetch(chrom).upper()
    
    positions = [m.start() for m in re.finditer(r'CG', seq)]
    
    fasta.close()
    
    positions = set(positions)

    return positions



def read_bismark_file(filename: str, ref: str) -> dict:
    result = dict()
    chrom_cache = dict()
    with open(filename, 'r') as f:
        for line in f:
            m = (line.strip()).split('\t')
            if m[0] in SUBJECT:
                if m[0] not in chrom_cache:
                    chrom_cache[m[0]] = get_cpg_c_positions(ref, m[0])

                if m[0] not in result:
                    result[m[0]] = dict()

                target = None
                if (int(m[1]) - 1) in chrom_cache[m[0]]:
                    target = int(m[1]) - 1
                elif (int(m[1]) - 2) in chrom_cache[m[0]]:
                    target = int(m[1]) - 2

                if target != None:
                    if target not in result[m[0]]:
                        result[m[0]][target] = [int(m[-2]), int(m[-1]) + int(m[-2])]
                    else:
                        result[m[0]][target][0] += int(m[-2])
                        result[m[0]][target][1] += (int(m[-1]) + int(m[-2]))


    return result
                




def write_output(bismark_dict: dict, output_file: str) -> None:
    write_line = 0
    with open(output_file, 'w') as out:
        for chrom in ALL_CHR:
            if chrom in bismark_dict:
                site = list(bismark_dict[chrom].keys())
                site.sort()
                for s in site:
                    meth, cov = bismark_dict[chrom][s]
                    per = f"{100*meth/cov:.2f}"
                        
                    to_write = [chrom, s, s + 1, 'm', cov, '.', s, s + 1, "255,0,0", cov, per, meth, cov - meth, '0', '0', '0', '0', '0']
                        
                    out.write('\t'.join([str(e) for e in to_write]))
                    out.write('\n')
                    write_line += 1

    print("ALL DONE")
    print(f"Written line : {write_line}")




if __name__ == "__main__":
    bismark_file = os.path.abspath(sys.argv[1])
    output_file = os.path.abspath(sys.argv[2])
    ref = os.path.abspath(sys.argv[3])

    bismark_dict = read_bismark_file(bismark_file, ref)
    
    write_output(bismark_dict, output_file)








