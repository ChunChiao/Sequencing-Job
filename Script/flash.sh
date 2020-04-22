#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=flash.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ITS1 and ITS4 sequences

module load flash 
module load perlbrew fastx
for file in trimmed/*ITS1*.fastq; do
	file2=$(ls $file | sed s/ITS1/ITS4/)
#	fastx_reverse_complement -i $file2 -o ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq"
#       fastx_reverse_complement -i $file -o ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"
#	flash -O -M 600 -o $(basename $file2.trim.fastq) -d mergedITS  ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"

	flash -M 600 -o $(basename $file2.trim.fastq) -d mergedITS ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"
done 


for file in trimmed/*ACTHVF*.fastq; do
        file2=$(ls $file | sed s/ACTHVF/ACTHVR/)
#        fastx_reverse_complement -i $file2 -o ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq"
#        fastx_reverse_complement -i $file -o ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"

        flash -M 800 -o $(basename $file2.trim.fastq) -d mergedACTHV ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"
done

