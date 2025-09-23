#!/bin/bash

# install awscli through pip
conda create -n aws python=3.9 -y;
conda activate aws;
pip install awscli;

