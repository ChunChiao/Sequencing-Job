#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge1.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ITS1 and ITS4 sequences

module load pear
module load perlbrew fastx 
rm mergedITS/*.fastq
rm ReverseComplement/*.fastq
mkdir ReverseComplement

for file in trimmed/*ITS1*.fastq; do
	file2=$(ls $file | sed s/ITS1/ITS4/)
	fastx_reverse_complement -i $file2 -o ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq"
        fastx_reverse_complement -i $file -o ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"	
	pear -f ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" -r ReverseComplement/"$(basename $file .trim.fastq).RC.fastq" -o mergedITS/"$(basename $file .trim.fastq)" -p 0.0001 -v 40	
done
