#!/bin/bash
#SBATCH --job-name=HyDe
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=32GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate phynest

cd /lustre/scratch/aosmansk/clean_out/phynest/HyDe/workdirs/QUARTET/
echo QUARTET

# Run the Julia script with the provided arguments
julia /lustre/scratch/aosmansk/clean_out/phynest/HyDe/workdirs/QUARTET/HyDe.jl &> QUARTET.log

