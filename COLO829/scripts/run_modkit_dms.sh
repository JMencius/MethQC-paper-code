#!/bin/bash

mkdir ../results/bs_dms;
mkdir ../results/ont_dms;

for i in COLO1 COLO2 COLO3 COLO4 COLO5; do
    for j in COLOBL1 COLOBL2 COLOBL3 COLOBL4 COLOBL5; do
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna -a ../results/bismark_convert/"$i".bismark.cov.bed.gz -b ../results/bismark_convert/"$j".bismark.cov.bed.gz --base C --out-path ../results/bs_dms/"$i"_"$j"_dms.bed;
    done
done



for i in COLO1 COLO2 COLO3 COLO4 COLO5; do
    for j in COLOBL1 COLOBL2 COLOBL3 COLOBL4 COLOBL5; do
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_dms/"$i"_"$j"_dms.bed;
    done
done

