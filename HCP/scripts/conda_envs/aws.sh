#!/bin/bash

# install awscli through pip
conda create -n aws python=3.9 -y;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda activate aws;
pip install awscli;

