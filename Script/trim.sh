#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=trim.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will take all fastq files in a folder named converted and quality trim them.

#Please note:  as trimmomatic is updated, the path to the trimmomatic jar file may need to be updated

rm trimmed/*.{fastq,fasta}
module load trimmomatic

for file in trimprimer/*.fastq; do
	java -jar ./trimmomatic-0.35.jar SE -phred33 $file trimmed/"$(basename "$file" .ptrim.fastq).trim.fastq" LEADING:35 TRAILING:20 #SLIDINGWINDOW:10:30 
done
