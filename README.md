# MethQC paper code
This repository archives the pipelines and source codes used in the MethQC manuscript.

## Contents
The contents are organized into six main folders. Please feel free to click on any title to view the step by step instructions.

1. [MethQC](./MethQC/MethQC.md)
   - Installation of MethQC

2. [Process and QC for ONT data](./ONT/scripts/ONT.md)
   - Preprocess of ONT data
   - Modkit pileup of methylation sites
   - Run MethQC quality control

3. [Process and QC for PacBio data](./PacBio/scripts/pacbio.md)
   - Preprocess of PacBio data
   - Modkit pileup of methylation sites
   - Run MethQC quality control

4. [Test MethQC on 161 groups of ONT data from Human Pangenome Reference Consortium (HPRC)](./HPRC/scripts/HPRC.md)
   - Preprocess of ONT data from HPRC
   - Test MethQC on HPRC data

5. [Test MethQC on the Hereditary Cancer Panel](./HCP/scripts/HCP.md)
   - Test MethQC on Hereditary Cancer Panel data
   - Inter-replicate RMSE

6. [How to download data from ScienceDB](./ScienceDB/README.md)
   - Instructions for downloading basecalled data from ScienceDB


## Requirement
### OS requirement
Codes were tested on _Linux_ operating systems. Linux: Ubuntu 22.04.1 is tested.


### Software requirements
#### Conda
Most of the following softwares are installed through `Conda` environment. We tested with Conda 22.11.1。

You can follow the Conda manual in [here](https://docs.anaconda.com/miniconda/) to install `Conda`.

We also provide a bash file for each conda environment. The installation of each conda environment may take several minutes, depending on your system and network speed.

#### Slurm
For testing MethQC on large-scale HPRC sample, we used slurm 21.08.8-2 on [SJTU HPC π 2.0](https://docs.hpc.sjtu.edu.cn/en/index.html).

#### Programming language
To run the Python scripts we provided, Python 3.8 or a higher version is required. 


#### Software version list
| Software | Version |
|:-----:|:-----:|
| AWScli | 2.24.12 |
| Dorado | 0.7.2, 0.9.5 |
| MethQC | 0.2.1 |
| Modkit | 0.5.0 |
| Pbmm2  | 1.17.0 |
| Python | 3.8.20 |
| Slurm  | 21.08.8-2 |
| Numpy  | 1.21.5 |


## Reproducibility checklist

To ensure that all analyses in the MethQC manuscript can be reproduced, we provide the following reproducibility details.

| Item | Description |
|:--|:--|
| **Code availability** | All scripts used in the MethQC manuscript are included in this repository under the corresponding folders (`MethQC/`, `ONT/`, `PacBio/`, `HPRC/`, and `HCP/`). |
| **Operating system** | All pipelines were tested on Linux (Ubuntu 22.04.1). No OS-specific commands are used. |
| **Hardware environment** | HPRC tests were executed on the SJTU HPC π 2.0 cluster using Slurm 21.08.8-2. Local examples were validated on standard x86_64 Linux workstations. ARM or Power9 system may enconter probles |
| **Data availability** | Some datasets used in the manuscript are publicly available via ScienceDB (see `ScienceDB/README.md` for download instructions). Others are publicly available from AWS S3 |
| **Dependency management** | Conda environments installation bash files were provieded. |
| **External resources** | All external tools (e.g., Dorado, Modkit, pbmm2) are version-locked and documented. No web-based API calls are required for main analyses. |
| **Test dataset** | A small test dataset and example pipeline (`examples/quickstart.sh`) are provided for verifying installation and environment correctness. |
| **Expected outputs** | Expected output files are listed in each README files. |

> ✅ By following these instructions and using the provided environment `.sh` file, users should be able to reproduce all quantitative results reported in the MethQC manuscript.


## Maintainers
[Jun Mencius](https://github.com/JMencius/) and [Shuo Jin](https://github.com/JinShuo0101/)

