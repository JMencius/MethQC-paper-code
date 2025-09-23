# MethQC paper code
This repository archives the pipelines and source codes used in the MethQC manuscript.

## Contents
The contents are organized into five main folders. Please feel free to click on any title to view the detailed `README.md`.

1. [Process and QC for ONT data](./ONT/scripts/ONT.md)
   - Preprocess of ONT data
   - Calculate correlation with oxBS-seq

2. [Process and QC for PacBio data](./PacBio/scripts/pacbio.md)
   - Preprocess of PacBio data
   - Calculate correlation with oxBS-seq

3. [MethQC on 161 groups of ONT data from Human Pangenome Reference Consortium (HPRC)](./HPRC/scripts/HPRC.md)

   - Preprocess of ONT data from HPRC
   - Benchmark MethQC on HPRC data

4. [How to download data from ScienceDB](./ScienceDB/README.md)
   
   Instructions for downloading basecalled data from ScienceDB


## Requirement
### OS requirement
Codes were tested on _Linux_ operating systems. The following release is tested:
Linux: Ubuntu 22.04.1

### Software requirement
#### Conda
Most of the following softwares are installed through `Conda` environment. We have run test on Conda version `22.11.1`.

You can follow the Conda manual in [here](https://docs.anaconda.com/miniconda/) to install `Conda`.

We also provide a bash file for each conda environment. The installation of each conda environment may take serveral minutes, depending on your system and network speed.

#### Slurm
For testing MethQC on large-scale HPRC sample, we used slurm 21.08.8-2 on [SJTU HPC π 2.0](https://docs.hpc.sjtu.edu.cn/en/index.html).

#### Programming language
To run the Python scripts we provided, Python 3.8 or a higher version is required. 

#### Software version list
| Software | Version |
|:-----:|:-----:|

