#!/bin/bash

for indir in $(ls -d ../data/*/);do
    buf=$(basename $indir)
    sname=$(basename "$buf")
    echo "Processing sample: $sname"

    mkdir -p ../results/aligned/$sname

    for bamfile in $(ls ../data/$sname/*_pass.bam); do
        echo $bamfile

        ./dorado-0.7.2-linux-x64/bin/dorado aligner --mm2-preset map-ont -t 80 ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna --output-dir ../results/aligned/$sname
    
    done

done


conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate samtools;


for indir in $(ls -d ../results/aligned/*/);do
    buf=$(basename $indir)
    sname=$(basename "$buf")
    echo "Processing sample: $sname"

    mkdir -p ../results/sorted/$sname

    samtools cat -@ 16 -o ../results/sorted/$sname/${sname}.unsorted.bam ../results/aligned/$sname/*.bam
    samtools sort -@ 16 -o ../results/sorted/$sname/${sname}.bam ../results/sorted/$sname/${sname}.unsorted.bam
    samtools index -@ 16 ../results/sorted/$sname/${sname}.bam

done
