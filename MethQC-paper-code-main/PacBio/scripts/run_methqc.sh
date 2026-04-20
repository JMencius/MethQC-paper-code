#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate methqc;


mkdir -p ../results/methqc;

ref=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna

for i in {1..5}; do
    methqc --verbose -t 32 --reference "$ref" -i ../results/bam/sample"$i"_aligned.bam -o ../results/methqc/sample"$i".html --detail-bed ../results/methqc/sample"$i".bed;
done

