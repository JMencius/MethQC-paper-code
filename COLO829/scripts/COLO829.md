# MethQC on differential methylation analysis between COLO829 and COLO829BL
## Brief
This directory archives the pipeline and environment for MethQC quality control on differential methylation analysis between COLO829 and COLO829BL. COLO829 is a malignant melanoma cell line and COLO829 BL is its patient-matched peripheral blood lymphoblastoid control cell line.


## data
Raw FAST5 file can be retrived from EPI2ME at <s3://ont-open-data/rrms_2022.07>.


Basecalled BAM files can be retrived from [ScienceDB](https://doi.org/10.57760/sciencedb.34487). Basecalling was conducted using `Guppy` v6.5.7 under HAC basecalling mode with 5mC methylation calling enabled.


## Software
### Install from conda environments
1. Awscli 
Use `pip` to install `awscli` as recommend in <https://github.com/aws/aws-cli>
```bash
bash ./conda_envs/aws.sh;
```

2. Htslib
Install from `bioconda`, details in <https://anaconda.org/bioconda/htslib>
```bash
bash ./conda_envs/htslib.sh;
```

3. Python3 and Python package for postanalysis
```bash
bash ./conda_envs/python_env.sh;
```

4. MethQC
To install `MethQC`, please follow the instruction in [here](../../MethQC/MethQC.md)

### Install from binary
1. Modkit
We directly download the precompiled binary release from nanoprotech <https://github.com/nanoporetech/modkit/releases>
```bash
bash ./download_modkit.sh


## Pipelines
0. Download basecalled BAM files from ScienceDB
Instructions are at [here](../../ScienceDB/README.md)

1. Download reference sequence and install software
```bash
bash download_rrms.sh;
bash download_hg38_ref.sh;
download_modkit.sh
bash install_conda_envs.sh;
```

2. Pileup ONT methylation
```bash
bash run_pileup.sh
```

3. Preprossed RRBS bismark results
```bash
bash bismark_convert.sh
```

4. Analysis differntial methylation sites for RRBS and ONT
```bash
bash run_modkit_dms.sh
```

5. MethQC for ONT methylation data
```bash
bash run_methqc.sh
```

6. Summarize QC effect
```bash
bash qc_effect.sh
```

7. Analysis false positive count
```bash
bash fp.sh
```

## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```

