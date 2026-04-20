import os
import sys



def read_region_file(filename: str) -> tuple:
    region_list = list()
    gene_list = list()    
    result = dict()

    with open(filename, 'r') as f:
        for line in f:
            m = line.split()
            region_list.append((m[0], m[1], m[2]))
            gene_list.append(m[3])

            result[f"{m[0]}:{m[1]}-{m[2]}"] = m[3]


    return result, region_list, gene_list


def read_log_file(filename: str, region_dict: dict) -> tuple:
    methylation_level = dict()
    mqi = dict()
    processing_time = dict()

    working_region = str()

    basename = os.path.basename(filename)
    gene = basename.split('.')[0] 

    with open(filename, 'r') as f:
        for line in f:
        
            if "Methylation percentage" in line:
                c_mper = float(line.split()[-1][:-1])
                c_mper /= 100

            if "Methylation quality index" in line:
                c_mqi = float(line.split()[-1])

            if "Total processing time" in line:
                c_time = float(line.split()[-2])
                
                methylation_level[gene] = c_mper
                mqi[gene] = c_mqi
                processing_time[gene] = c_time


    return (methylation_level, mqi, processing_time)


if __name__ == "__main__":
    logdir = os.path.abspath(sys.argv[1])
    region_file = os.path.abspath(sys.argv[2])

    region_dict, region_list, gene_list = read_region_file(region_file)
 
    print(f"Regions count: {len(region_dict.keys())}")

    methylation_level, mqi, processing_time = dict(), dict(), dict()
    
    for afile in os.listdir(logdir):
        if "log" in afile:
            a, b, c = read_log_file(os.path.join(logdir, afile), region_dict)
            
            methylation_level.update(a)
            mqi.update(b)
            processing_time.update(c)


    output = os.path.abspath(sys.argv[3])

    with open(output, 'w') as f:
        for idx in range(len(region_list)):
            chrom, start, end = region_list[idx]
            f.write('\t'.join([chrom, start, end, gene_list[idx], str(mqi[gene_list[idx]]), str(methylation_level[gene_list[idx]]), str(processing_time[gene_list[idx]]) ]))
            f.write('\n')







