#!/bin/bash
#SBATCH --job-name=POrtho
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --mem=500GB

cd /lustre/scratch/aosmansk/proteinortho

export proteinortho=/lustre/work/aosmansk/apps/proteinortho/proteinortho6.pl
export diamond=/lustre/work/aosmansk/apps/diamond

perl /lustre/work/aosmansk/apps/proteinortho/proteinortho6.pl \
 -verbose \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cJoh_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cInt_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cCro_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cAcu_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/aSin_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/aMis_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cMor_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cMin_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cLat_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cPor_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cPal_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cNov_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cNil_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cYac_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cSia_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/cRho_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/oTet_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/mNig_galba.faa \
 /lustre/scratch/aosmansk/proteinortho/amino_acid_files/mCat_galba.faa


