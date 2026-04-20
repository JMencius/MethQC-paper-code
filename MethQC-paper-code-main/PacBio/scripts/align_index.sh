#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate pbmm2;


mkdir -p ../results/bam;

ref=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta

# HG002
pbmm2 align --preset CCS -m 2G -j 64 --sort "$ref" ../data/m84011_220902_175841_s1.hifi_reads.bam > ../results/bam/sample1_aligned.bam;
pbmm2 align --preset CCS -m 2G -j 64 --sort "$ref" ../data/m84005_220919_232112_s2.hifi_reads.bam > ../results/bam/sample2_aligned.bam;
pbmm2 align --preset CCS -m 2G -j 64 --sort "$ref" ../data/m84005_220827_014912_s1.hifi_reads.bam > ../results/bam/sample3_aligned.bam;

# HG003
pbmm2 align --preset CCS -m 2G -j 64 --sort "$ref" ../data/m84010_220919_235306_s2.hifi_reads.bam > ../results/bam/sample4_aligned.bam;

# HG004
pbmm2 align --preset CCS -m 2G -j 64 --sort "$ref" ../data/m84010_220919_235306_s2.hifi_reads.bam > ../results/bam/sample5_aligned.bam;


# index bam files
for i in ../results/bam; do
    samtools index -@ 16 *.bam;
done

