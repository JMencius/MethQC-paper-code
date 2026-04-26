#!/bin/bash


for s in ../results/sorted; do
    for bam in ../results/sorted/"$s"/*.bam; do
        fname=$(basename "$bam" .bam)
        mkdir -p ../results/modkit/"$s";
        ./dist_modkit_v0.6.0_68b540b/modkit pileup --reference ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --modified-bases C:m --filter-threshold C:0.75 --threads 16 --cpg --combine-strands "$bam" ../results/modkit/"$s"/"$fname"_modkit.bed;
    done
done

