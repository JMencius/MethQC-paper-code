#!/bin/bash

# 1. Download reference sequence and install software
bash download_rrms.sh;
bash download_hg38_ref.sh;
download_modkit.sh
bash install_conda_envs.sh;

# 2. Pileup ONT methylation
bash run_pileup.sh

# 3. Preprossed RRBS bismark results
bash bismark_convert.sh

# 4. Analysis differntial methylation sites for RRBS and ONT
bash run_modkit_dms.sh

# 5. MethQC for ONT methylation data
bash run_methqc.sh

# 6. Summarize QC effect
bash qc_effect.sh

# 7. Analysis false positive count
bash fp.sh

