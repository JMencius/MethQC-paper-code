#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate aws;

mkdir -p ../data/R10;


while read url; do
    ## parse url automatically
    sample=$(echo "$url" | awk -F'/' '{print $(NF-3)}')
    flowcell=$(echo "$url" | awk -F'/' '{print $(NF-2)}')
    mode=$(echo "$url" | awk -F'/' '{print $(NF-4)}')

    out="/path/to/save/${sample}_${flowcell}_${mode}.bam"
    aws s3 cp --no-sign-request "$url" "$out"

done < ../data/EPI2ME.txt


