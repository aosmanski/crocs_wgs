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

astral -t 32 -u 3 -i all_bestTrees_cleaned.nwk -o astral.out.nwk
