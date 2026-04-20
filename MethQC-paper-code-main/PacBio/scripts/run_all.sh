#!/bin/bash

## 1. Download reference sequence and install software
bash download_hg38_ref.sh;
bash download_modkit.sh;
bash install_conda_envs.sh;


# test if conda envs exists
conda env list | grep -q '^pbmm2 ' || { echo "Conda environment aws not found!"; exit 1; }
conda env list | grep -q '^methqc ' || { echo "Conda environment methqc not found!"; exit 1; }


## 2. Download data from PacBio cloud
download_pacbcloud_data.sh;


## 3. Conduct alignment and samtools index         
bash align_index.sh;


## 4. Run modkit pileup
bash run_modkit.sh;


## 5. Run MethQC quality control
bash run_methqc.sh;
