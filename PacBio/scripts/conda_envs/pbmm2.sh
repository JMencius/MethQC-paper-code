#!/bin/bash

conda create -n pbmm2 -y;
conda activate pbmm2;
conda install -c bioconda pbmm2=1.17.0;
conda install -c bioconda samtools;
