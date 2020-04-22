#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=mergeACT.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ACTHVF and ACTHVR sequences using phred score 64 standard 

module load pear
module load perlbrew fastx
mkdir mergedACTHV
rm mergedACTHV/*.fastq
rm ReverseComplement/*.fastq
mkdir ReverseComplement

for file in trimmed/*ACTHVF*.fastq; do
        file2=$(ls $file | sed s/ACTHVF/ACTHVR/)
	fastx_reverse_complement -Q 33 -i $file2 -o ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq"
        fastx_reverse_complement -Q 33 -i $file -o ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"
        pear -f ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" -r ReverseComplement/"$(basename $file .trim.fastq).RC.fastq" -o mergedACTHV/"$(basename $file .trim.fastq)" -p 0.0001 -v 40 -b 33  
	#pear -f $file2 -r $file -o mergedACTHV/"$(basename $file .trim.fastq)" -p 0.0001 -v 40 -b 33 
done
