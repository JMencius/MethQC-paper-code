#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate aria2c;


INPUT="hprc_data_link.txt"
BASE_DIR="../data"

while IFS=$'\t' read -r url sample
do
 
    [ -z "$sample" ] && continue

    
    OUT_DIR="../data/${sample}/"
    mkdir -p "$OUT_DIR"

    echo "Downloading $url"
    echo " -> $OUT_DIR"

    aria2c --file-allocation=none --allow-overwrite=false -c -s 20 -x 16 -j 20 -d "$OUT_DIR" "$url"

done < "$INPUT"



