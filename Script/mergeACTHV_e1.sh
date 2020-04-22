#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge_ACTHV_e1.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ACTHVF and ACTHVR sequences using EMBOSS merger application

module load emboss

for file in trimmed/*ACTHVF*.fastq; do
	file2=$(ls $file | sed s/ACTHVF/ACTHVR/)
	merger $file $file2 -sreverse -outseq mergedACTHV/"$(basename $file .trim.fastq)"consensus.fasta -outfile mergedACTHV/"$(basename $file .trim.fastq)"
	
done
