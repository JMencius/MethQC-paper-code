#!/bin/bash

mkdir -p ../results/qc_effect

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate python_env;

for normal_idx in 1 2 3 4 5; do
    for tumor_idx in 1 2 3 4 5; do
        python qc_effect "$normal_idx" "$tumor_idx" 0;
    done
done

