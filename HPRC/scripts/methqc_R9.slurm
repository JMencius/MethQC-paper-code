#!/bin/bash
#SBATCH --job-name=methqc_020
#SBATCH --partition=cpu
#SBATCH -n 40
#SBATCH --ntasks-per-node=40
#SBATCH --output=./log/methqc_020_fixed_R9_%a.out
#SBATCH --error=./log/methqc_020_fixed_R9_%a.err
#SBATCH --array=0-160

# Methylation quality control (MethQC) for long-read sequencing

source activate methqc

i=$SLURM_ARRAY_TASK_ID

snames=()
for indir in $(ls -d ../results/sorted/*/);do
    buf=$(basename $indir)
    snames+=("$buf")
done

sname=${snames[i]}

nthreads=$(nproc)
echo "nthreads = $nthreads"

indir=../results/sorted
outdir=../results/methqc_output
reffile=../ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna

echo "indir=$indir"
echo "outdir=$outdir"
echo "reffile=$reffile"

mkdir -p $outdir/${sname}

time methqc --verbose \
--detail-bed $outdir/${sname}/${sname}.bed \
-i $indir/${sname}/${sname}.bam \
-r $reffile \
-t $nthreads \
-o $outdir/${sname}/${sname}.html

# collect JobID to individal txt file
echo "${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID},${sname}" > $outdir/${sname}/${sname}_jobid.txt
