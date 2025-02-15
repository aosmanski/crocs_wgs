#!/bin/bash
#SBATCH --job-name=MauSNPs
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=320GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash
conda activate iqtree

cd /lustre/scratch/aosmansk/crocs/IQtree/topology_tests

iqtree2 -s ../create_biallelic_SNP_tree/croc_biallelic_SNPs.phy -z snp_alternative_topologies.trees --prefix snp_topo_test -n 0 -zb 10000 -au -T 128
