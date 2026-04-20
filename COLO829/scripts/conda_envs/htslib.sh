#!/bin/bash

conda create -n htslib -y;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate htslib;
conda install -c bioconda htslib;
