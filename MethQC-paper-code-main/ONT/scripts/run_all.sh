#!/bin/bash


## 1. Download reference sequence and install software
bash download_hg38_ref.sh;
bash download_modkit.sh;
bash install_conda_envs.sh;

# test if conda envs exists
conda env list | grep -q '^aws ' || { echo "Conda environment aws not found!"; exit 1; }
conda env list | grep -q '^samtools ' || { echo "Conda environment samtools not found!"; exit 1; }
conda env list | grep -q '^methqc ' || { echo "Conda environment methqc not found!"; exit 1; }


## 2. Download data from EPI2ME and ScienceDB
bash download_EPI2ME_data.sh


# Download R9 basecalled BAM from ScienceDB manually
echo "Please download R9 basecalled BAM from ScienceDB manually from https://doi.org/10.57760/sciencedb.27334"
echo "Instructions is at https://github.com/JMencius/MethQC-paper-code/tree/main/ScienceDB"


## 3. Conduct samtools index for EPI2ME data
bash samtools_index.sh;


## 4. Run modkit pileup
bash run_modkit.sh;


## 5. Run MethQC quality control
bash run_methqc.sh;
