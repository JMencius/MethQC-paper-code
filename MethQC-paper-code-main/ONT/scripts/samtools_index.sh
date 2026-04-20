#!/bin/bash

## R10 data
for i in ../data/R10/*.bam; do
    samtools index -@ 16 "$i";
done

