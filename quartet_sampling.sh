#!/bin/bash
#SBATCH --job-name=quartet_sampling
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

cd /lustre/scratch/aosmansk/crocs/IQtree/topology_tests

iqtree2 -t scortho_topology.tree --scf 5000 -s ../create_SCORTHO_tree/SCORTHOS.supermatrix.phy --prefix conflict_scf -T 64 --cf-verbose
