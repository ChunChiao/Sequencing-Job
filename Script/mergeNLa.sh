#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge2a.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge NL1 and NL4 sequences that contains IUPAC ambiguity code 

module load pear
rm mergedNL/*.fastq
mkdir ReverseComplement

for file in trimmed/*NL*.fastq; do
        file2=$(ls $file | sed s/NL1/NL4/)
        bash reformat.sh -in $file2 -out ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" 'qin=33' overwrite=true rcomp=true
        bash reformat.sh -in $file -out ReverseComplement/"$(basename $file .trim.fastq).RC.fastq" 'qin=33' overwrite=true rcomp=true
        pear -f ReverseComplement/“$(basename $file2 .trim.fastq).RC.fastq" -r ReverseComplement/“$(basename $file .trim.fastq).RC.fastq" -o mergedNL/"$(basename $file .trim.fastq).consensus.fastq)" -p 0.0001 -v 40 -b 33      
done
