#!/bin/bash
#SBATCH --job-name=CODEML
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4GB
#SBATCH -a 1-1950

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate paml

NAMESFILE=/lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/batch1
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

cd /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/workdirs_redo/${SCORTHO}/alt/

codeml alt_model2_trimal.ctl < /dev/null &> log.txt

cd /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/workdirs_redo/${SCORTHO}/nul/

codeml nul_model2_trimal.ctl < /dev/null &> log.txt

