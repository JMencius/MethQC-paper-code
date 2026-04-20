#!/bin/bash

mkdir -p ../results/methqc

for i in 1 2 3 4 5; do
    for s in COLO829 COLO829BL; do
        methqc -i ../data/"$s"_"$i".bam -r ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna --modkit ./dist_modkit_v0.6.0_68b540b/modkit --detail_bed ../results/methqc/"$s"_"$i".bed
    done
done


