#!/bin/bash
#SBATCH --job-name=MP.1r
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --mem=128GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
#conda activate emboss

cd /lustre/scratch/aosmansk/clean_out/PhyloNet/MP

java -jar /lustre/work/aosmansk/apps/phylonet/PhyloNet.jar InferNetwork_MP.1retic.pl64.nex &> InferNetwork_MP.1retic.out
