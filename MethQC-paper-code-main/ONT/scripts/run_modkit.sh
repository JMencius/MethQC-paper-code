#!/bin/bash

mkdir -p ../results/modkit;

ref=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna


## R9 data
mkdir -p ../results/R9_modkit;

for i in ../data/R9/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}"
    ./dist_modkit_v0.5.0_5120ef7/modkit -t 64 --reference "$ref" --motif CG 0 --combine-strands --ignore h "$i" ../results/R10_modkit/"$name".bed;
done



## R10 data
mkdir -p ../results/R10_modkit;

for i in ../data/R10/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}"
    ./dist_modkit_v0.5.0_5120ef7/modkit -t 64 --reference "$ref" --motif CG 0 --combine-strands --ignore h "$i" ../results/R10_modkit/"$name".bed;
done
