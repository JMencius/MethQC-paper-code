import os
import math
import sys
import numpy as np

def read_beds(f1, f2, f3):
    result = dict()

    files = [f1, f2, f3]

    for filename in files:
        with open(filename, 'r') as f:
            for line in f:
                m = (line.strip()).split('\t')
                if m[5] != "nan" and int(m[4]) != 0:
                    if int(m[1]) not in result:
                        result[int(m[1])] = list()
                    result[int(m[1])].append(float(m[5]))
                else:
                    if int(m[1]) not in result:
                        result[int(m[1])] = list()
                    result[int(m[1])].append(None)

    return result 


def read_gene_list(filename: str) -> list:
    genes = list()
    with open(filename, 'r') as f:
        for line in f:
            m = (line.strip()).split()
            genes.append(m[3])

    return genes



if __name__ == "__main__":

    gene_list = read_gene_list(os.path.abspath(sys.argv[1]))
    output = os.path.abspath(sys.argv[2])

    avg_rmse = list()
    for gene in gene_list:
        print(f"Processing {gene}")
        f1 = os.path.abspath(os.path.abspath(f"../results/barcode07/{gene}.bed"))
        f2 = os.path.abspath(os.path.abspath(f"../results/barcode08/{gene}.bed"))
        f3 = os.path.abspath(os.path.abspath(f"../results/barcode09/{gene}.bed"))

        result = read_beds(f1, f2, f3)
        x1 = list()
        x2 = list()
        rmses = list()

        for i in result.values():
            if i[0] != None and i[1] != None:
                x1.append(i[0])
                x2.append(i[1])
 
   
        if len(x1) > 2:
            rmse1 = np.sqrt(np.mean((np.array(x1) - np.array(x2))**2))
            rmses.append(pcc1)
    
        x1 = list()
        x3 = list()

        for i in result.values():
            if i[0] != None and i[2] != None:
                x1.append(i[0])
                x3.append(i[2])

        if len(x1) > 2:
            rmse2 = np.sqrt(np.mean((np.array(x1) - np.array(x3))**2))
            rmses.append(pcc2)

        x2 = list()
        x3 = list()

        for i in result.values():
            if i[1] != None and i[2] != None:
                x2.append(i[1])
                x3.append(i[2])

        if len(x2) > 2:
            rmse3 = np.sqrt(np.mean((np.array(x3) - np.array(x2))**2))
            rmses.append(pcc3)


        if len(pccs) == 3:
            avg_rmse.append(sum(pccs) / 3)
        else:
            avg_rmse.append(None)

    print("Writing output file")
    with open(output, 'w') as f:
        for i, j in zip(gene_list, avg_rmse):
            f.write(f"{i}\t{j}")
            f.write('\n')


    print("ALL DONE")
