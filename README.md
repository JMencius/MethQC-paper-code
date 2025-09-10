# MethQC paper code
This repository archives the pipelines and source codes used in the MethQC manuscript.

## Contents
The contents are organized into five main folders. Please feel free to click on any title to view the detailed `README.md`.
1. [Process and QC for ONT data](./ONT/README.md)
   - Preprocess of ONT data
   - Calculate correlation with oxBS-seq
   - Calcultate MethQC related metrics

2. [Process and QC for PacBio data](./PB/README.md)

   - Preprocess of PacBio data
   - Calculate correlation with oxBS-seq
   - Calcultate MethQC related metrics

3. [MethQC on compartive samples](./comparative/README.md)

   - MethQC on comparative samples

4. [MethQC on 161 groups of ONT data from Human Pangenome Reference Consortium (HPRC)](./HPRC/README.md)

   - Preprocess of ONT data
   - Benchmark MethQC on HPRC data

5. [How to download data from ScienceDB](./ScienceDB/README.md)
   
   Instructions for downloading basecalled data from ScienceDB


## Requirement
### OS requirement
Codes were tested on _Linux_ operating systems. The following release is tested:
Linux: Ubuntu 22.04.1

### Software requirement
#### Conda
Most of the following softwares are installed through `Conda` environment. We have run test on Conda version `22.11.1`.

You can follow the Conda manual in [here](https://docs.anaconda.com/miniconda/) to install `Conda`.

We also provide a `.sh` file for each conda enironment. The installation of each conda environment may take serveral minutes, depending on your system and network speed.

#### Slurm
For large scale HPRC sample, we run test on slurm 21.08.8-2 on [SJTU HPC π 2.0](https://docs.hpc.sjtu.edu.cn/en/index.html).

#### Programming language
To run the Python scripts we provided, Python 3.8 or a higher version is required. 

#### Software version list
| Software | Version |
