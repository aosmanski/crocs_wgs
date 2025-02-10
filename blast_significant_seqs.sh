#!/bin/bash
#SBATCH --job-name=blast
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=16GB
#SBATCH -a 1-91

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the blast environment
conda activate blast

NAMESFILE=/lustre/scratch/aosmansk/crocs/selection_tests/PAML/significant_seqs/4_fresh_crocs/significant_SCORTHOS
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

cd /lustre/scratch/aosmansk/crocs/selection_tests/PAML/significant_seqs/4_fresh_crocs/blast/workdirs/${SCORTHO}/

#/lustre/scratch/aosmansk/crocs/selection_tests/PAML/significant_seqs/4_fresh_crocs/blast/workdirs/30/30.sig_scortho.fas

blastx -query ${SCORTHO}.sig_scortho.fas \
       -db /lustre/scratch/aosmansk/blastdb/nr \
       -out ${SCORTHO}.blastx_results.txt \
       -evalue 1e-10 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident evalue stitle sseq" \
       -num_threads 8
