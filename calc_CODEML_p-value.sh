#!/bin/bash
#SBATCH --job-name=calcP
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4GB
#SBATCH -a 1-1950

NAMESFILE=/lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/batch1
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate scipy

cd /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML

python calc_p_value.py \
 -alt /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/workdirs_redo/${SCORTHO}/alt/mlc.out \
 -nul /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/workdirs_redo/${SCORTHO}/nul/mlc.out \
 -id ${SCORTHO} >> /lustre/scratch/aosmansk/scratch/july/HA/crocs/PAML/workdirs_redo/${SCORTHO}/${SCORTHO}.LRT_model2_freshwater.txt
