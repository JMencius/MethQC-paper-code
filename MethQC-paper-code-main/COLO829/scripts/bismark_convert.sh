#!/bin/bash

mkdir -p ../results/bismark_covert

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate python_env;

for i in ../data/*.bismark.cov; do
    echo "$i";
    name=$(basename "$i")
    echo "$name"
    python bismark2methylbed.py "$i" ../results/bismark_covert/"$name".bed ../ref//GCA_000001405.15_GRCh38_no_alt_analysis_set.fna;
done

