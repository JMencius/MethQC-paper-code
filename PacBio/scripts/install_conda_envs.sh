#!/bin/bash

conda --version;

for i in ./conda_envs/*.sh; do
    bash "$i";
done
