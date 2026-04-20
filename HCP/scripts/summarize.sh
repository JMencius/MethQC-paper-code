#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate analysis;

python summarize_methqc_results.py ../results/methqc/barcode07 ./HCP_regions.txt ../results/barcode07_methqc_results.txt;
python summarize_methqc_results.py ../results/methqc/barcode08 ./HCP_regions.txt ../results/barcode08_methqc_results.txt;
python summarize_methqc_results.py ../results/methqc/barcode09 ./HCP_regions.txt ../results/barcode09_methqc_results.txt;


