import os
import sys
from scipy.stats import pearsonr
import numpy as np
import matplotlib.pyplot as plt


def plot_density_heatmap(x, y, save_path, lb=False):
    x, y = np.array(x), np.array(y)
    mask = ~np.isnan(x) & ~np.isnan(y)
    x, y = x[mask], y[mask]

    if len(x) == 0: return

    r, _ = pearsonr(x, y)
    m, c = np.polyfit(x, y, 1)

    plt.figure(figsize=(6, 5))
    
    lims = [0, 1] if lb else [-1, 1]
    weights = np.ones_like(x) / len(x) * 100
    
    h = plt.hist2d(x, y, bins=20, range=[lims, lims], weights=weights, cmap='Blues', cmin=1e-5, vmin = 0, vmax = 1)
    plt.colorbar(h[3], label='Percentage (%)')

    x_line = np.linspace(lims[0], lims[1], 10)
    plt.plot(x_line, m * x_line + c, color='cyan', lw=1.5, ls='--')

    plt.xlim(lims); plt.ylim(lims)
    plt.xlabel("X"); plt.ylabel("Y")

    label_str = f'$R^2 = {r**2:.3f}$\n$Slope = {m:.3f}$'
    plt.text(0.05, 0.95, label_str, transform=plt.gca().transAxes,
             color='white', fontsize=12, verticalalignment='top',
             bbox=dict(facecolor='black', alpha=0.5, edgecolor='none'))

    plt.tight_layout()
    plt.savefig(save_path, dpi=800)
    plt.close()


def get_mqi_bool(filename) -> dict:
    bool_dict = dict()
    with open(filename, 'r') as f:
        for line in f:
            m = (line.strip()).split()
            if m[0] not in bool_dict:
                bool_dict[m[0]] = dict()
            b = True
            if int(m[4]) < 5:
                b = False
            else:
                if m[-2] != "nan" and float(m[-2]) < 40:
                    b = False
                else:
                    if m[-1] != "nan" and float(m[-1]) > 0.3:
                        b = False
            bool_dict[m[0]][m[1]] = b


    return bool_dict



def read_dms_file(filename, depth_filter) -> dict:
    dms = dict()
    linecount = 0
    with open(filename, 'r') as f:
        for line in f:
            if linecount == 0:
                linecount += 1
                continue

            m = (line.strip()).split()
            if m[0] not in dms:
                dms[m[0]] = dict()

            if depth_filter:
                if int(m[7]) < 10 or int(m[9]) < 10:
                    continue

            diff = float(m[-6]) - float(m[-7])
            dms[m[0]][m[1]] = (diff, float(m[-6]), float(m[-7]))

    return dms



if __name__ == "__main__":
    norm_idx = str(sys.argv[1])
    tumor_idx = str(sys.argv[2])
    output_bool = bool(str(sys.argv[3]))    

    bs_dms = read_dms_file(os.path.abspath(f"../results/bs_dms/norm{norm_idx}_tumor{tumor_idx}_dms.bed"), True)
    ont_dms = read_dms_file(os.path.abspath(f"../results/ont_dms/norm{norm_idx}_tumor{tumor_idx}_dms.bed"), False)

    diff_x, diff_y = list(), list()

    for c in bs_dms:
        if c in ont_dms:
            for site in bs_dms[c]:
                if site in ont_dms[c]:
                    diff_x.append(ont_dms[c][site][0])
                    diff_y.append(bs_dms[c][site][0])


    raw_r, _ = pearsonr(diff_x, diff_y)


    norm_bool_dict = get_mqi_bool(os.path.abspath(f"../results/methqc_bed/COLO829BL_{norm_idx}.bed"))
    tumor_bool_dict = get_mqi_bool(os.path.abspath(f"../results/methqc_bed/COLO829_{tumor_idx}.bed"))

    filtered_x, filtered_y = list(), list()
    new_x, new_y = list(), list()
    for c in bs_dms:
        if c in ont_dms:
            for site in bs_dms[c]:
                if site in ont_dms[c]:
                    if norm_bool_dict[c][site] == False and tumor_bool_dict[c][site] == False:
                        filtered_x.append(ont_dms[c][site][0])
                        filtered_y.append(bs_dms[c][site][0])
                    else:
                        new_x.append(ont_dms[c][site][0])
                        new_y.append(bs_dms[c][site][0])

    pass_r, _ = pearsonr(new_x, new_y)


    fail_r, _ = pearsonr(filtered_x, filtered_y)
    
    if output_bool:
        plot_density_heatmap(diff_x, diff_y, "ori.svg")
        plot_density_heatmap(new_x, new_y, "pass.svg")
        plot_density_heatmap(filtered_x, filtered_y, "fail.svg")    

    print(raw_r**2, pass_r**2, fail_r**2)


