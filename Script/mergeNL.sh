#!/bin/bash -l
# 
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge2.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge NL1 and NL4 sequences

module load pear
module load perlbrew fastx
mkdir mergedNL
rm mergedNL/*.fastq
rm ReverseComplement/*.fastq
for file in trimmed/*NL1*trim.fastq; do
        file2=$(ls $file | sed s/NL1/NL4/)
        fastx_reverse_complement -i $file2 -o ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq"
        fastx_reverse_complement -i $file -o ReverseComplement/"$(basename $file .trim.fastq).RC.fastq"
        pear -f ReverseComplement/"$(basename $file2 .trim.fastq).RC.fastq" -r ReverseComplement/"$(basename $file .trim.fastq).RC.fastq" -o mergedNL/"$(basename $file .trim.fastq)" -p 0.0001 -v 40 -b 33
done
