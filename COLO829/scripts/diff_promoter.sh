#!/bin/bash

mkdir -p ../results/qc_effect

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate methylkit;


mkdir -p ../results/diff_promoter;


for i in 1 2 3 4 5; do
    for j in 1 2 3 4 5; do
        python diff_promoter.py "$i" "$j";
    done
done


