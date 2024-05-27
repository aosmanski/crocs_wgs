#!/bin/bash
#SBATCH --job-name=cAcu
#SBATCH --output=%x.o%j
#SBATCH --error=%x.o%j
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --mem=96GB


#Set up the arguments
GENOME=cNov
WORKDIR=/lustre/scratch/aosmansk/de_novo_assemblies/assemblies/$GENOME
FASTQ_FILES=/lustre/scratch/aosmansk/croc_150bp_wgs_fastqs

cd $WORKDIR

/lustre/work/aosmansk/apps/bwa-0.7.17/bwa mem -M -R "@RG\tID:GGEClass\tPL:illumine\tPU:Unknown\tLB:lc_paired\tSM:GGEClass" $REF_DIR/$REFERENCE.fas -t 64 $FASTQ_FILES/$GENOME"_R1.fastq.gz" $FASTQ_FILES/$GENOME"_R2.fastq.gz" | /lustre/work/aosmansk/apps/samtools/samtools-1.20/samtools view -Sb -@ 64 -o "bwa_"$REFERENCE"_"$GENOME".bam"

#/lustre/work/aosmansk/apps/new_gatk/gatk-4.2.4.1/gatk SortSam --SORT_ORDER coordinate -I "bwa_"$REFERENCE"_"$GENOME".bam" -O "bwa_"$REFERENCE"_"$GENOME"_sort.bam" -MAX_RECORDS_IN_RAM 1000000 -VALIDATION_STRINGENCY LENIENT -CREATE_INDEX TRUE -TMP_DIR tmp

#This method of sorting seemed to play nicer with downstream analyses
/lustre/work/aosmansk/apps/samtools/samtools-1.9/samtools sort -o "bwa_"$REFERENCE"_"$GENOME"_sort.bam" "bwa_"$REFERENCE"_"$GENOME".bam"
/lustre/work/aosmansk/apps/samtools/samtools-1.9/samtools index "bwa_"$REFERENCE"_"$GENOME"_sort.bam"

/lustre/work/aosmansk/apps/new_gatk/gatk-4.2.4.1/gatk MarkDuplicates -I "bwa_"$REFERENCE"_"$GENOME"_sort.bam" -O "bwa_"$REFERENCE"_"$GENOME"_marked.bam" -M "bwa_"$REFERENCE"_"$GENOME"_dupMetric.bam" -REMOVE_DUPLICATES TRUE -MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 1000000 -VALIDATION_STRINGENCY LENIENT -CREATE_INDEX TRUE -ASSUME_SORTED TRUE -TMP_DIR tm

/lustre/work/aosmansk/apps/new_gatk/gatk-4.2.4.1/gatk HaplotypeCaller -R $REF_DIR/$REFERENCE.fas -I "bwa_"$REFERENCE"_"$GENOME"_marked.bam" -O "bwa_"$REFERENCE"_"$GENOME"_marked.vcf"

/lustre/work/daray/software/freebayes/vcflib/bin/vcffilter -f "QUAL > 30" "bwa_"$REFERENCE"_"$GENOME"_marked.vcf" > "bwa_"$REFERENCE"_"$GENOME"_calls_gt30.vcf"

/lustre/work/daray/software/freebayes/vcflib/bin/vcfstats "bwa_"$REFERENCE"_"$GENOME"_calls_gt30.vcf" > "bwa_"$REFERENCE"_"$GENOME"_stats.txt"
