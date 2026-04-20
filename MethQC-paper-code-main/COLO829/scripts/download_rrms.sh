#!/bin/bash

mkdir -p ../rrms/data

aws s3 sync \
--no-sign-request \
--exclude "*" \
--include "COLO*" \
s3://ont-open-data/rrms_2022.07/bisulfite/methylation_call/ \
./rrms/data


