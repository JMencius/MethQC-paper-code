#!/bin/bash

mkdir -p ../results/modkit

for i in 1 2 3 4 5; do
    modkit -t 64 --reference ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna --modified-bases C:m --threads 40 --cpg --combine-strands ../data/bam/COLO829_"$i".bam ../results/modkit/COLO"$i".bed
done

for i in 1 2 3 4 5; do
    modkit -t 64 --reference ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna --modified-bases C:m --threads 40 --cpg --combine-strands ../data/bam/COLO829BL_"$i".bam ../results/modkit/COLO"$i"BL.bed
done


conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate htslib;

# compress and tabix modkit pileup results
for b in ../results/modkit/*.bed; do
    bgzip "$b";
    tabix -p bed "$b".gz;
done

