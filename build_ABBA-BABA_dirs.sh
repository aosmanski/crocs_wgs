#!/bin/bash
#SBATCH --job-name=ABBA-BABA-dirs
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -a 1-27
#SBATCH --mem=4GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate biopython

NAMESFILE=/lustre/scratch/aosmansk/clean_out/ABBA-BABA/HYBRID-LIST
QUAD=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

cd /lustre/scratch/aosmansk/clean_out/ABBA-BABA/

mkdir $QUAD
cd $QUAD

#######################################
# Make the list. This will be the input for downstream stuff.

IFS="-" read -ra array <<< $QUAD

# Create the "LIST" file
touch LIST

# Iterate over the array and write each element to the "LIST" file
for element in "${array[@]}"
do
    echo "$element" >> LIST
done

######################################
mkdir alignments

for SCORTHO in $(cat /lustre/scratch/aosmansk/clean_out/ABBA-BABA/SCORTHOS); \
 do for SPP in $(cat LIST); do \
 grep -A 1 $SPP /lustre/scratch/aosmansk/clean_out/ABBA-BABA/SCORTHO_alignments_SL/"NEW_SCORTHO_${SCORTHO}.aln.SL.fas" \
 >> ./alignments/"${QUAD}.SCORTHO.${SCORTHO}.aln.SL.fas"; done; done


#Shoot off the ABBA-BABA script
for SCORTHO in $(cat ../SCORTHOS); do python /lustre/scratch/aosmansk/clean_out/ABBA-BABA/ABBA-BABA_counts.py ./alignments/"${QUAD}.SCORTHO.${SCORTHO}.aln.SL.fas" >> "${QUAD}.ABBA-BABA.txt"; done

