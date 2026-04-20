import os
import sys
import bisect


PVALUE_CUTOFF = 0.05

def check(intervals, starts, c):
    if not intervals:
        return False

    i = bisect.bisect_right(starts, c) - 1

    if i < 0:
        return False

    a, b = intervals[i]

    return a <= c <= b

def get_mqi_bool(filename) -> dict:
    #print(f"Reading {filename}")
    bool_dict = dict()
    with open(filename, 'r') as f:
        for line in f:
            m = (line.strip()).split()
            if m[0] not in bool_dict:
                bool_dict[m[0]] = dict()
            if m[-1] == "PASS":
                b = True
            else:
                b = False
            
            bool_dict[m[0]][m[1]] = b


    return bool_dict


def read_dms_file(filename, region):
    #print(f"Reading {filename}")
    fp_count = 0
    with open(filename, 'r') as f:
        for line in f:
            if line.startswith('#'):
                continue

            m = (line.strip()).split('\t')
            if m[0] not in region:
                continue
            check_bool = check(region[m[0]][0], region[m[0]][1], int(m[1]))
            
            if check_bool:
                if abs(float(m[-5])) <= PVALUE_CUTOFF:
                    fp_count += 1

    return fp_count


def read_dms_file_filter(filename, normal_mqi, tumor_mqi, region):
    #print(f"Reading {filename}")
    fp_count = 0
    with open(filename, 'r') as f:
        for line in f:
            if line.startswith('#'):
                continue

            m = (line.strip()).split('\t')
            if m[0] not in region:
                continue
            check_bool = check(region[m[0]][0], region[m[0]][1], int(m[1]))
            if not check_bool:
                continue

            if m[0] in normal_mqi and m[0] in tumor_mqi:
                if m[1] in normal_mqi[m[0]] and m[1] in tumor_mqi[m[0]]:
                    total_site_count += 1
                    if normal_mqi[m[0]][m[1]] and tumor_mqi[m[0]][m[1]]:
                        if abs(float(m[-5])) <= PVALUE_CUTOFF:
                            fp_count += 1
                else:
                    if abs(float(m[-5])) <= PVALUE_CUTOFF:
                        fp_count += 1 
   

    return fp_count


def read_region(filename):
    #print(f"Reading {filename}")
    region = dict()
    with open(filename, 'r') as f:
        for line in f:
            m = (line.strip('\t')).split()
            if m[0] not in region:
                region[m[0]] = list()

            region[m[0]].append((int(m[1]), int(m[2])))

    clean = dict()
    for i, j in region.items():
        v = sorted(j, key = lambda K: K[0])
        clean[i] = (v, [i[0] for i in v])

    return clean



if __name__ == "__main__":
    norm_idx = str(sys.argv[1])
    tumor_idx = str(sys.argv[2])

    region = read_region(os.path.abspath("./RRMS_human_hg38.sorted.bed"))

    control_dms_file = os.path.abspath(f"../results/ont_internal_dms/COLO829BL_{norm_idx}_COLO829BL_{tumor_idx}_dms.bed")
    exp_dms_file = os.path.abspath(f"../results/ont_internal_dms/COLO829BL_{norm_idx}_COLO829_{tumor_idx}_dms.bed")
    normA_methqc_file = os.path.abspath(f"../results/methqc_bed/COLO829BL_{norm_idx}.bed")
    normB_methqc_file = os.path.abspath(f"../results/methqc_bed/COLO829BL_{tumor_idx}.bed")
    tumorB_methqc_file = os.path.abspath(f"../results/methqc_bed/COLO829_{tumor_idx}.bed")

    fp_value = read_dms_file(control_dms_file, region)


    normA_mqi = get_mqi_bool(normA_methqc_file)
    normB_mqi = get_mqi_bool(normB_methqc_file)
    tumorB_mqi = get_mqi_bool(tumorB_methqc_file)

    filtered_fp_value = read_dms_file_filter(control_dms_file, normA_mqi, normB_mqi, region)

    print(f"{fp_value}\t{filtered_fp_value}")
