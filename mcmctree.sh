#!/bin/bash
#SBATCH --job-name=MCMCtree
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=8GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash
conda activate paml

cd /lustre/scratch/aosmansk/crocs/dated_trees/MCMCTree/updated_date_ranges

mcmctree mcmctree.ctl &> log.txt
