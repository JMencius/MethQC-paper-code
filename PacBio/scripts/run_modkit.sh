#!/bin/bash

mkdir -p ../results/modkit;

ref=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna

for i in {1..5}; do
    ./dist_modkit_v0.5.0_5120ef7/modkit -t 80 --reference "$ref" --motif CG 0 --combine-strands --ignore h ../results/bam/sample"$i"_aligned.bam ../results/modkit/sample"$i".bed;
done
