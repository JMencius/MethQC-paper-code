#!/bin/bash


conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate aws;

mkdir -p ../data;


aws s3 sync --no-sign-request s3://ont-open-data/hereditary_cancer_2025.09/analysis/FC02 ../data;

