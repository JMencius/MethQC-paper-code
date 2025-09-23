#!/bin/bash

# 1. Download reference sequence and install software
bash download_hg38_ref.sh;
bash download_dorado.sh;
bash install_conda_envs.sh;

# test if conda envs exists
conda env list | grep -q '^aws ' || { echo "Conda environment aws not found!"; exit 1; }
conda env list | grep -q '^samtools ' || { echo "Conda environment samtools not found!"; exit 1; }
conda env list | grep -q '^methqc ' || { echo "Conda environment methqc not found!"; exit 1; }


# 2. Download HPRC data
bash download_hprc_data.sh;

# 3. Conduct alignment and samtools postprocessing
bash align_sort_index.sh;


# 4. Test MethQC
## We used slurm 21.08.8-2 on [SJTU HPC π 2.0](https://docs.hpc.sjtu.edu.cn/en/index.html). If you don't have slurm install, please use the for loop in Linux Bash.
mkdir -p ../results/methqc_output;
sbatch --version;
sbatch methqc_R9.slurm;
