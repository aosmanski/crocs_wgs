#!/bin/bash
#SBATCH --job-name=catVCFs
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=16GB

## Initialize conda
source ~/conda/etc/profile.d/conda.sh
conda init bash

## Activate the TEclass2 environment
conda activate bcftools

cd /lustre/scratch/aosmansk/july/Dsuite/VCFs

bcftools concat \
 -a \
 -O z \
 -o all_croc_SNP_calls_gt30_cPorREF.vcf.gz \
 bwa_cPor_cAcu_calls_gt30.vcf.gz \
 bwa_cPor_cInt_calls_gt30.vcf.gz \
 bwa_cPor_cJoh_calls_gt30.vcf.gz \
 bwa_cPor_cMin_calls_gt30.vcf.gz \
 bwa_cPor_cMor_calls_gt30.vcf.gz \
 bwa_cPor_cNil_calls_gt30.vcf.gz \
 bwa_cPor_cNov_calls_gt30.vcf.gz \
 bwa_cPor_cPal_calls_gt30.vcf.gz \
 bwa_cPor_cRho_calls_gt30.vcf.gz \
 bwa_cPor_cSia_calls_gt30.vcf.gz \
 bwa_cPor_mCat_calls_gt30.vcf.gz \
 bwa_cPor_oTet_calls_gt30.vcf.gz
