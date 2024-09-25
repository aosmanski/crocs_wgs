#!/bin/bash
#SBATCH --job-name=dsuite
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=16GB

cd /lustre/scratch/aosmansk/scratch/july/Dsuite/dsuite_run1

/lustre/work/aosmansk/apps/dsuite/Dsuite/Build/Dsuite Dtrios -t croc.u1.astralNOhybrid.NOaMis.DsuiteIN.nwk -o dsuite_crocs_bi-allelic_SNPs --ABBAclustering merged_output_SNPs_only.vcf SETS.txt
