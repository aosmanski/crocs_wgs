#!/bin/bash
#SBATCH --job-name=raxmlSUPP
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem=64GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate raxml

cd /lustre/scratch/aosmansk/clean_out/july/HA/crocs/phylogeny/astral

raxml-ng --support --tree croc.u1.astralNOhybrid.aMisROOT.nwk --bs-trees bestTrees_cleaned.nwk --prefix gene_concordance
