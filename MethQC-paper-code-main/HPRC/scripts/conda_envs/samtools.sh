#!/bin/bash

conda create -n samtools;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda install -c bioconda samtools=1.6

