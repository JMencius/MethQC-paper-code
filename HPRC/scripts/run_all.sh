# 1. Download GRCh38 reference and precompiled Dorado, install conda environments
bash download_hg38_ref.sh;
bash download_dorado.sh;
bash download_modkit.shl
bash install_conda_envs.sh;

# 2. Download HPRC data
bash download_hprc_data.sh;

# 3. Conduct alignment and samtools postprocessing
bash align_sort_index.sh;

# 4. Run Modkit pileup
bash run_modkit.sh;

#5. Run MethQC
bash run_methqc.sh;

# 6. Calculate overdisperion
bash cal_od.sh;
