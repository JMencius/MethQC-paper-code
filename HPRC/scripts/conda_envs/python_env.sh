#!/bin/bash

conda create -n python_env python=3.8 -y

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

pip install numpy;

