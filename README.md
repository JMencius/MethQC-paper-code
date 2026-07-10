# MethQC paper code  
This repository contains the pipelines and source code used in the MethQC manuscript.


## Contents  
The repository is organized into the following main folders. Click on each section for step-by-step instructions.

1. [MethQC](./MethQC/MethQC.md)  
   - Installation of MethQC  

2. [Process and QC for ONT data of the Ashkenazi Jewish trio](./ONT/scripts/ONT.md)  
   - Preprocessing of ONT data  
   - Modkit pileup of methylation sites  
   - Running MethQC for quality control  

3. [Process and QC for PacBio data of the Ashkenazi Jewish trio](./PacBio/scripts/pacbio.md)  
   - Preprocessing of PacBio data  
   - Modkit pileup of methylation sites  
   - Running MethQC for quality control  

4. [Test MethQC on 161 ONT datasets from the Human Pangenome Reference Consortium (HPRC)](./HPRC/scripts/HPRC.md)  
   - Preprocessing of ONT data from HPRC  
   - Evaluation of MethQC on HPRC data  

5. [Test MethQC on the Hereditary Cancer Panel](./HCP/scripts/HCP.md)  
   - Evaluation on hereditary cancer panel data  
   - Inter-replicate RMSE analysis  

6. [Test MethQC on differential methylation analysis](./COLO829/scripts/COLO829.md)  
   - Quality control for differential methylation analysis  
   - False positive evaluation with and without quality control
   - Differential methylation analysis for gene promoter regions 

7. [How to download data from ScienceDB](./ScienceDB/README.md)  
   - Instructions for downloading basecalled data from ScienceDB  

---

## Requirement  

### OS requirement  
The code has been tested on Linux operating systems, specifically Ubuntu 22.04.1.

### Software requirements  

#### Conda  
Most dependencies are installed via Conda (tested with Conda 22.11.1).  

You can install Conda by following the official guide:  
https://docs.anaconda.com/miniconda/  

We also provide bash scripts for creating each Conda environment. Installation may take several minutes depending on system configuration and network speed.


#### Programming language  
Python 3.8 or higher is required to run the provided scripts.  

#### Software version list  

| Software | Version |
|:--------:|:-------:|
| AWScli   | 2.24.12 |
| Dorado   | 0.7.2, 0.9.5 |
| MethQC   | 0.5.2 |
| Modkit   | 0.6.0 |
| Pbmm2    | 1.17.0 |
| Python   | 3.8.20 |
| Samtools | 1.22 |
| MethylKit| 1.36.0 | 
| Numpy    | 1.21.5 |
| Scipy    | 1.7.3 |
| Statmodels | 0.14.6 |

---

## Reproducibility checklist  

To ensure reproducibility of all analyses in the MethQC manuscript, we provide the following details:

| Item | Description |
|:--|:--|
| **Code availability** | All scripts used in the MethQC manuscript are included in this repository under the corresponding folders (`MethQC/`, `ONT/`, `PacBio/`, `HPRC/`, `COLO829/`, and `HCP/`). |
| **Operating system** | All pipelines were tested on Linux (Ubuntu 22.04.1). No OS-specific commands are required. |
| **Hardware environment** | Tests were validated on standard `x86_64` Linux workstations. `ARM` or `Power9` operating systems may encounter compatibility issues. |
| **Data availability** | Some datasets are publicly available via ScienceDB (see `ScienceDB/README.md`). Others are accessible from AWS S3. |
| **Dependency management** | Conda environment installation scripts are provided. |
| **External resources** | All external tools (e.g., Dorado, Modkit, and pbmm2) are version-locked and documented. Python packages without strict version requirements are not version-pinned. |




