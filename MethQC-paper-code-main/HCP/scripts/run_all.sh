#!/bin/bash

## Pipelines
# 1. Download reference sequence and install software

bash download_reference;
bash install_conda_envs.sh;
 

# 2. Download data from EPI2ME S3
bash download_HCP_data.sh


# 3. Run MethQC quality control for each gene
bash run_methqc.sh;


# 4. Calculate inter-replicate RMSE
bash cal_rmse.sh
