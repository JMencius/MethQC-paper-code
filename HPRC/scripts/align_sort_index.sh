#!/bin/bash

mkdir -p ../results/aligned;
mkdir -p ../results/sorted;

for i in ../data/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}"  

    ./dorado-0.9.5-linux-x64/bin/dorado align -t 80 --mm2-opts "-x map-ont" ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna > ../results/aligned/"$name"_aligned.bam”;

done



conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate samtools;


for i in ../results/aligned/*.bam; do
    echo "$i";
    filename=$(basename "$i")
    name="${filename%.*}"

    samtools sort -@ 16 "$i" -o ../results/sorted/"$name"_sorted.bam;
    samtools index -@ 32 ../results/sorted/"$name"_sorted.bam;

done

