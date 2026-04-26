#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate python_env;


mkdir -p ../results/od;

for s in ../results/modkit/*; do
    python cal_od.py > ../results/od/"$s".txt;
done

