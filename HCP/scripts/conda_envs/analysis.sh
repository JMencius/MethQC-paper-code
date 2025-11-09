#!/bin/bash

conda create -n analysis python=3.7 -y;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate analysis;

pip install "numpy>=1.21.5"

