# Large-scale test of MethQC on HPRC samples
## Description

This directory archives the pipeline and environment for large-scale test of 161 groups of ONT sequencing data from Human Pangenome Reference Consortium (HPRC). For more information of HPRC, one can refer to <https://www.nature.com/articles/s41586-023-05896-x>.


## Software
### Install from conda environments
1. Samtools
Install from `bioconda`, details in <https://anaconda.org/bioconda/samtools>
```bash
bash ./conda_envs/samtools.sh;
```

### Install from binary
2. Dorado
We directly download the binary release from the official Dorado release <https://github.com/nanoporetech/dorado>
```bash
bash ./download_dorado.sh;
```


## Data 
Metadata of the 161 ONT samples are summarized in [here](../data/hprc_samples_metadata.csv).


## Pipelines
1. Download reference sequence and install software
```bash
bash download_hg38_ref.sh;
bash download_dorado.sh;
bash install_conda_envs.sh;
```

2. Download HPRC data
```bash
bash download_rawdata.sh;
```

3. Conduct alignment and samtools postprocessing
```bash
bash align_sort_index.sh;
```

4. Test MethQC
We used slurm 21.08.8-2 on [SJTU HPC π 2.0](https://docs.hpc.sjtu.edu.cn/en/index.html). If you don't have slurm install, please use the for loop in Linux Bash.
```bash
mkdir -p ../results/methqc_output;
sbatch methqc_R9.slurm;
```


## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```




