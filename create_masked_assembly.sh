#!/bin/bash
#SBATCH --job-name=mask
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -a 1-20
#SBATCH --mem-per-cpu=32MB

module load gcc/10.1.0 bedtools2/2.29.2

RMPATH=/lustre/work/daray/software/RepeatMasker-4.1.0/util

NAMESFILE=/lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker/RM_LIST
CHRANGE=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)

GENOME=${CHRANGE}_ref-based_assembly

cd /lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker/${CHRANGE}_RM

gunzip -c ${GENOME}.fa.out.gz > ${GENOME}.fa.out

perl $RMPATH/rmOutToGFF3.pl ${GENOME}.fa.out > ${GENOME}.fa.gff

bedtools maskfasta -soft -fi ${GENOME}.fas -bed ${GENOME}.fa.gff -fo ${GENOME}.masked.fas

#Prepare gff file for MAKER

grep -v -e "Satellite" -e ")n" -e "-rich"  ${GENOME}.fa.gff | perl -ane '$id; if(!/^\#/){@F = split(/\t/, $_); chomp $F[-1];$id++; $F[-1] .= "\;ID=$id"; $_ = join("\t", @F)."\n"} print $_' > ${GENOME}_reformat.gff3'
