#!/bin/bash
#SBATCH --job-name=IPS_sig
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH -a 1-91
#SBATCH --mem=16G

NAMESFILE=/lustre/scratch/aosmansk/crocs/selection_tests/interproscan/significant_SCORTHOS
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash
conda activate biopython

cd /lustre/scratch/aosmansk/crocs/selection_tests/interproscan/workdirs/$SCORTHO/

# Set Java memory options
export JAVA_OPTS="-XX:+UseParallelGC -XX:ParallelGCThreads=8 -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -Xms1G -Xmx12G"

/lustre/work/aosmansk/apps/interproscan/interproscan-5.67-99.0/interproscan.sh \
    -i $SCORTHO.sig_scortho.faa \
    -cpu 8 \
    -goterms \
    -iprlookup \
    -pa \
    -f TSV,GFF3 \
    -t p
