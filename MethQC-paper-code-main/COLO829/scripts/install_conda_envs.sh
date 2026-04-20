#!/bin/bash

for i in ./conda_envs/*.sh; do
    bash "$i"
done

