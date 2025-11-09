# MethQC on ONT data
## Brief
This directory archives the pipeline and environment for MethQC quality control for ONT data.

## data
### R10
Basecalled BAM files were retrived from [EPI2ME](https://epi2me.nanoporetech.com/giab-2025.01/) using AWS `s3`.

### R9
We downloaded the `FAST5` files of HG002, HG003, and HG004 from HPRC. `Guppy` 4.2.2 and `Guppy` 6.3.8 were used to conduct basecalling.

Basecalled BAM files can be retrived freely through [ScienceDB](https://doi.org/10.57760/sciencedb.27334) under the CC BY-NC-ND 4.0 license.

Details for downloading files from ScienceDB is in [here](../../ScienceDB/README.md).


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

### Install from binary
3. Modkit
We directly download the binary release from the Github <https://github.com/nanoporetech/modkit/releases>
```bash
bash ./download_modkit.sh;
```


## Pipelines
1. Download reference sequence and install software
```bash
bash download_hg38_ref.sh;
bash download_modkit.sh;
bash install_conda_envs.sh;
``` 


2. Download data from EPI2ME and ScienceDB
```bash
bash download_EPI2ME_data.sh

# Download R9 basecalled BAM from ScienceDB manually
```

3. Conduct samtools index for EPI2ME data
```bash
bash samtools_index.sh;
```  

4. Run modkit pileup
```bash
bash run_modkit.sh;
```

5. Run MethQC quality control
```bash
bash run_methqc.sh;
```


## Results
1. Modkit pileup bed files are stored in `../results/R9_modkit` and `../results/R10_modkit`.

2. MethQC quality control files (Interactive HTML files and detailed BED files) are store in `../results/R9_methqc` and `../results/R10_methqc`.


## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```

