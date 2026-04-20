# MethQC on Hereditary Cancer Panel (HCP)
## Brief
This directory archives the pipeline and environment for MethQC quality control on Hereditary Cancer Panel data.

## data
Basecalled BAM files were retrived from [EPI2ME](https://epi2me.nanoporetech.com/hereditary_cancer_2025.09/) using AWS `s3`.


## Software
### Install from conda environments
1. Awscli 
Use `pip` to install `awscli` as recommend in <https://github.com/aws/aws-cli>
```bash
bash ./conda_envs/aws.sh;
```

2. Samtools
Install from `bioconda`, details in <https://anaconda.org/bioconda/samtools>
```bash
bash ./conda_envs/samtools.sh;
```

3. Numpy and Python3 for postanalysis
Use `pip` to install `numpy`
```bash
bash ./conda_envs/analysis.sh;
```


## Pipelines
1. Download reference sequence and install software
```bash
bash download_reference;
bash install_conda_envs.sh;
``` 

2. Download data from EPI2ME S3
```bash
bash download_HCP_data.sh
```

3. Run MethQC quality control for each gene
```bash
bash run_methqc.sh;
```

4. Calculate inter-replicate RMSE
```bash
bash cal_rmse.sh
```



## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```
