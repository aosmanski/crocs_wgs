#!/bin/bash
#SBATCH --job-name=6.6_trimal
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -a 1-1790

NAMESFILE=/lustre/scratch/aosmansk/clean_out/croc_phylogeny/SCORTHOS_6.6
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate trimal

cd /lustre/scratch/aosmansk/clean_out/croc_phylogeny/workdirs_trimal/$SCORTHO

#Create a trimmed phylip alignment using ClipKit & a custom python script:
trimal -in /lustre/scratch/aosmansk/clean_out/workdirs_trimal/SCORTHO_alignments_ABRV/"NEW_SCORTHO_${SCORTHO}.aln.SL.ABRV.fas" -out "NEW_SCORTHO_${SCORTHO}.aln.SL.ABRV.TRIMAL.fas" -automated1
