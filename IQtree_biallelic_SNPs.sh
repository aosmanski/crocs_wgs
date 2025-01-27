#!/bin/bash
#SBATCH --job-name=IQtree
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=256GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash
conda activate iqtree

cd /lustre/scratch/aosmansk/crocs/IQtree

iqtree2 -s croc_biallelic_SNPs.phy -m MFP -nt 64 --mem 256G -bb 1000 -pre IQtree_biallelicSNPs_tree -o mCat,oTet
