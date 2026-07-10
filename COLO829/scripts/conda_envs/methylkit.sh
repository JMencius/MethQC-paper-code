#!/bin/bash

conda create -n methylkit python=3.10 -y

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate methylkit;
conda install -c conda-forge -c bioconda r-base bioconductor-methylkit rpy2;
pip install statsmodels;

