#!/bin/bash
#SBATCH --job-name=6.6_mafft
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -a 1-1790
#SBATCH --mem=4GB

#10,715 single-copy orthologs identified. 
#Had to break the runs into 5 parts because I can't run more than 2000 jobs at a time on this cluster.
#SCORTHOS_6.1 through SCORTHOS_6.6 were the names of the list files which contained each 
#  single-copy orthologous gene ID.

NAMESFILE=/lustre/scratch/aosmansk/clean_out/croc_phylogeny/SCORTHOS_6.6
FAS=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

cd /lustre/scratch/aosmansk/clean_out/croc_phylogeny/

/lustre/work/aosmansk/apps/mafft-7.525-with-extensions/core/mafft --anysymbol /lustre/scratch/aosmansk/clean_out/croc_phylogeny/unaligned_SCORTHO_new_fastas/"NEW_SCORTHO_"$FAS".fas" > /lustre/scratch/aosmansk/clean_out/croc_phylogeny/aligned_SCORTHO_new_fastas/"NEW_SCORTHO_"$FAS".aln.fas"
