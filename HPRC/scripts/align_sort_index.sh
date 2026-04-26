#!/bin/bash


# align to reference genome
for s in $(ls -d ../data/*/); do
    mkdir -p ../results/align/"$s"

    i=1
    for bam in ../data/"$sname"/*.bam; do
        ./dorado-1.4.0-linux-x64/bin/dorado aligner \
            -t 40 \
            --mm2-opts "-x map-ont" \
            ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta \
            "$bam" > ../results/align/"$sname"/"$sname"_rep"$i".bam
        ((i++))

done


# samtools sort and index
conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate samtools;


for s in ../results/align/*; do
    mkdir -p ../results/sorted/"$s";
    for bam in ../results/align/"$s"/*.bam; do
        fname=$(basename "$bam" .bam)
        samtools sort -@ 16 -o "../results/sorted/"$s"/${fname}_sorted.bam" "$bam"
        samtools index -@ 16 "./results/sorted/"$s"/${fname}_sorted.bam"
    done
done

