# Large-scale test of MethQC on HPRC samples
## Description

This directory archives the pipeline and environment for large-scale test of 123 groups of ONT sequencing data from Human Pangenome Reference Consortium (HPRC). For more information of HPRC, one can refer to <https://www.nature.com/articles/s41586-023-05896-x>.


## Software
### Install from conda environments
1. Samtools
Samtools was install from `bioconda` channel, details in <https://anaconda.org/bioconda/samtools>
```bash
bash ./conda_envs/samtools.sh;
```

2. Aria2c
Aria2c was used to download HPRC BAM files. Aria2c was install from `conda-forge` channel, details in <https://anaconda.org/channels/conda-forge/packages/aria2/overview>
```bash
bash ./conda_envs/aria2c.sh;
```

3. Python
Python environment for overdispersion calculation
```bash
bash ./conda_envs/python_env.sh;
```

4. MethQC
Please follow the instruction in [here](../../MethQC/MethQC.md)



### Install from binary
1. Dorado
We directly download the precompiled binary release from the official Dorado release <https://github.com/nanoporetech/dorado>
```bash
bash ./download_dorado.sh;
```

2. Modkit
We directly download the precompiled binary release from nanoprotech <https://github.com/nanoporetech/modkit/releases>
```bash
bash ./download_modkit.sh
```


## Pipelines
1. Download GRCh38 reference and precompiled Dorado, install conda environments
```bash
bash download_hg38_ref.sh;
bash download_dorado.sh;
bash download_modkit.shl
bash install_conda_envs.sh;
```

2. Download HPRC data
```bash
bash download_hprc_data.sh;
```

3. Conduct alignment and samtools postprocessing
```bash
bash align_sort_index.sh;
```

4. Run Modkit pileup
```bash
bash run_modkit.sh;
```

5. Run MethQC
```bash
bash run_methqc.sh;
```

6. Calculate overdisperion
```bash
bash cal_od.sh;
```


## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```




