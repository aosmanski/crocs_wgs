#!/bin/bash
#SBATCH --job-name=coverage
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=8GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate samtools


#NAMESFILE=/lustre/scratch/aosmansk/clean_out/croc_ref-based_assembly_workdir/coverage/LIST
#SPP=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)
SPP=$1

cd /lustre/scratch/aosmansk/clean_out/croc_ref-based_assembly_workdir/coverage/workdirs/$SPP


#samtools sort -o $SPP.sort.bam *$SPP.bam

echo "SPECIES= " $SPP

samtools coverage $SPP.sort.bam


