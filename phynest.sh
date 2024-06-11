#!/bin/bash
#SBATCH --job-name=NW_phyne
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


cd /lustre/scratch/aosmansk/clean_out/phynest/new_world

# Run the Julia script with the provided arguments
julia phynest.jl -p NewWorld.SCORTHOS.supermatrix.trimal.phy -t new_world.tre -o cNil -c 8 &> log
