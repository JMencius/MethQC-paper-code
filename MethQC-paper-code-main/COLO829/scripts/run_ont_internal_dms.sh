#!/bin/bash

mkdir -p ../results/ont_internal_dms

for i in COLO829BL_1; do
    for j in COLO829BL_2 COLO829BL_3 COLO829BL_4 COLO829BL_5 COLO829_2 COLO829_3 COLO829_4 COLO829_5; do
        echo "$i $j"
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_internal_dms/"$i"_"$j"_dms.bed;
    done
done

for i in COLO829BL_2; do
    for j in COLO829BL_1 COLO829BL_3 COLO829BL_4 COLO829BL_5 COLO829_1 COLO829_3 COLO829_4 COLO829_5; do
        echo "$i $j"
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_internal_dms/"$i"_"$j"_dms.bed;
    done
done

for i in COLO829BL_3; do
    for j in COLO829BL_1 COLO829BL_2 COLO829BL_4 COLO829BL_5 COLO829_1 COLO829_2 COLO829_4 COLO829_5; do
        echo "$i $j"
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_internal_dms/"$i"_"$j"_dms.bed;
    done
done

for i in COLO829BL_4; do
    for j in COLO829BL_1 COLO829BL_2 COLO829BL_3 COLO829BL_5 COLO829_1 COLO829_2 COLO829_3 COLO829_5; do
        echo "$i $j"
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_internal_dms/"$i"_"$j"_dms.bed;
    done
done

for i in COLO829BL_5; do
    for j in COLO829BL_1 COLO829BL_2 COLO829BL_3 COLO829BL_4 COLO829_1 COLO829_2 COLO829_3 COLO829_4; do
        echo "$i $j"
        ./dist_modkit_v0.6.0_68b540b/modkit dmr pair --header -t 64 --ref ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -a ../results/modkit/"$i"_modkit.bed.gz -b ../results/modkit/"$j"_modkit.bed.gz --base C --out-path ../results/ont_internal_dms/"$i"_"$j"_dms.bed;
    done
done

