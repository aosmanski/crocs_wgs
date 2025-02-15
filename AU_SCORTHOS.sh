#!/bin/bash
#SBATCH --job-name=auSCORTHOS
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

iqtree2 -s ../create_SCORTHO_tree/SCORTHOS.supermatrix.phy -z scortho_alternative_topologies.trees --prefix scortho_topo_test -n 0 -zb 10000 -au -T 64
