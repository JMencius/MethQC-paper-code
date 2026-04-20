#!/bin/bash

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;
conda activate analysis;


python cal_rmse.py HCP_regions.txt ../results/avg_rmse.txt;
