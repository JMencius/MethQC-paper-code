# MethQC on PacBio data
## Brief

This directory archives the pipeline and environment for MethQC quality control for PacBio data.

Methylation called bam files were retrived from [PacBio cloud](https://www.pacb.com/connect/datasets/).


## Software
### Install from conda environments
1. pbmm2
Use `conda` to install `pbmm2` as recommend in <https://github.com/aws/aws-cli>


2. methqc
Details are in [here](../../MethQC.md)


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


2. Download data from PacBio cloud
```bash
download_pacbcloud_data.sh;
```

3. Conduct alignment and samtools index
```bash
bash align_index.sh;
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
1. Samples index
| Sample | Index |
|:---:|:---:|
| HG002 | Sample1, Sample2, Sample3 |
| HG003 | Sample4 |
| HG004 | Sample5 |


2. Alighed BAM files are stored in `../results/bam`.

3. Modkit pileup bed files are stored in `../results/modkit`.

4. MethQC quality control files (Interactive HTML files and detailed BED files) are store in `../results/methqc`.


## Repeat our results
To repeat our results, please run `run_all.sh`
```bash
bash ./run_all.sh;
```

