#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate samtools;

# download from UCSC
mkdir -p ../ref;
wget -P ../ref https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.masked.gz;

# decompress and index
gzip -dk ../ref/hg38.fa.masked.gz;
mv hg38.fa.masked hg38.masked.fa;
samtools faidx ../ref/hg38.masked.fa;

