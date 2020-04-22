#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=mergeemb.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ITS1 and ITS4 sequences using EMBOSS merger 

module load emboss

for file in trimmed/*ITS1*.fastq; do
	file2=$(ls $file | sed s/ITS1/ITS4/)
	merger $file $file2 -sreverse -outseq mergedITS/"$(basename $file .trim.fastq)"consensus.fasta -outfile mergedITS/"$(basename $file .trim.fastq)"
	
done
