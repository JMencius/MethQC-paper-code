#!/bin/bash

conda create -n aria2c;

conda_base=$(conda info --base);
source "$conda_base"/etc/profile.d/conda.sh;

conda install conda-forge::aria2;
