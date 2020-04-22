#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge1a.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge ITS1F and ITS4 sequences that contains IUPAC ambiguity code 

module load bbmap java samstool
module load pear
rm mergedITS/*.fastq
mkdir ReverseComplement

for file in trimmed/*ITS1F*.fastq; do
        file2=$(ls $file | sed s/ITS1F/ITS4/)
	
	reformat.sh in=$file2 out=ReverseComplement/$(echo $(basename $file2 .trim.fastq)".RC.fastq") 'qin=33' rcomp=t
	reformat.sh in=$file out=ReverseComplement/$(echo $(basename $file .trim.fastq)".RC.fastq") 'qin=33' rcomp=t
        pear -f ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" -r ReverseComplement/“$(basename $file .trim.fastq).RC.fastq" -o mergedITS/"$(basename $file .trim.fastq).consensus.fastq)" -p 0.0001 -v 40 -b 33      
done
