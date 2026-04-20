#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate methqc;


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
regions_file="$script_dir/HCP_regions.txt"


mkdir -p ../results;


for j in ../data/FC02/*; do
    bam=$(basename "$j")
    
    echo "$bam"

    mkdir -p ../results/methqc/"$bam"

    awk '{print $1 ":" $2 "-" $3, $4}' "$regions_file" | while read region gene; do
        echo "Processing $region ($gene)"
        methqc --verbose --nums-only -t 8 \
            --region "$region" \
            -i "$j/$bam.haplotagged.bam" \
            -r ../ref/hg38.masked.fa \
            --detail-bed ../results/methqc/"$bam"/"$gene".bed \
            > ../results/methqc/"$bam"/"$gene".log 2>&1
    done
done
