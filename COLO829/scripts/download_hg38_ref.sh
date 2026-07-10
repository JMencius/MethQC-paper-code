#!/bin/bash

mkdir -p ../ref;

# Download reference genome
wget -P ../ref https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz;

gzip -dk ../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz;


# Download annotation file
wget -P ../ref https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.gtf.gz;

gzip -dk ../ref/GCF_000001405.40_GRCh38.p14_genomic.gtf.gz;

