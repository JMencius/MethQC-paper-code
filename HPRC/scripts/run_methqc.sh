#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate methqc;


for s in ../results/sorted; do
    for bam in ../results/sorted/"$s"/*.bam; do
        fname=$(basename "$bam" .bam)
        mkdir -p ../results/methqc/"$s";
        methqc -t 40 -r ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna -i "$bam" --nums-only -f 0.75 > ../results/methqc/"$s"/"$fname".log 2>&1;
    done
done

