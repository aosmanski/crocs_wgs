#!/bin/bash
#SBATCH --job-name=cAcuMEM
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --mem=96GB

#Set up array job for 19 crocodilian species
SPECIES=$1

#Navigate to the main directory
cd /lustre/scratch/aosmansk/ab_initio_gene_prediction/

#Get the SIF file into the path
export GALBA_SIF=/lustre/scratch/aosmansk/ab_initio_gene_prediction/galba.sif

#Set up a working directories
WORKDIR=/lustre/scratch/aosmansk/ab_initio_gene_prediction/MEM/${SPECIES}

#Location of the masked assemblies
MASKED_ASSEMBLY=/lustre/scratch/aosmansk/ab_initio_gene_prediction/masked_assemblies/cAcu.masked.fas

#Location of the OrthoDB Vertebrata
DB=/lustre/scratch/aosmansk/ab_initio_gene_prediction/croc_ODBproteins.fasta

# Run galba through singularity container
singularity exec -B ${WORKDIR}:${WORKDIR} ${GALBA_SIF} galba.pl \
--species=cAcu8 \
--genome=$MASKED_ASSEMBLY \
--prot_seq=$DB \
--threads=64 \
--workingdir=${WORKDIR} \
--AUGUSTUS_ab_initio \
--gff3 \
