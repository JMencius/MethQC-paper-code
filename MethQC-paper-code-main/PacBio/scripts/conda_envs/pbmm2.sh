#!/bin/bash

conda create -n pbmm2 -y;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate pbmm2;
conda install -c bioconda pbmm2=1.17.0;
conda install -c bioconda samtools;
