#!/bin/bash

conda create -n python_env python=3.7 -y;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate python_env;
pip install samtools;
pip install numpy;
