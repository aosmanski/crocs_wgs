#!/bin/bash
#SBATCH --job-name=astral
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem=32GB


## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate aster

cd /lustre/scratch/aosmansk/clean_out/croc_phylogeny/aster

astral-hybrid -t 32 -u 1 --mode 1 -S -i astralIN.bestTrees.NOscorthoID.support.nwk -o croc.support.astral.nwk
