#!/bin/bash
#SBATCH --job-name=6.6_IPS
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -a 1-1790

NAMESFILE=/lustre/scratch/aosmansk/clean_out/interproscan/SCORTHOS_6.6
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate biopython

cd /lustre/scratch/aosmansk/clean_out/interproscan/workdirs/$SCORTHO/

/lustre/work/aosmansk/apps/interproscan/interproscan-5.67-99.0/interproscan.sh -i $SCORTHO.fas

#/lustre/scratch/aosmansk/clean_out/interproscan/workdirs/cPor_g10115.t1/cPor_g10115.t1.fas
