#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate methqc;

ref=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna

## R9 data
mkdir -p ../results/R9_methqc;

for i in ../data/R9/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}" 
    methqc --verbose -t 32 --reference "$ref" -i "$i" -o ../results/R9_methqc/"$name".html --detail-bed ../results/R9_methqc/"$name".bed;
done


## R10 data
mkdir -p ../results/R10_methqc;

for i in ../data/R10/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}"
    methqc --verbose -t 32 --reference "$ref" -i "$i" -o ../results/R10_methqc/"$name".html --detail-bed ../results/R10_methqc/"$name".bed;
done

