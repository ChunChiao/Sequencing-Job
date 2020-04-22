#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=merge2.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will merge NL1 and NL4 sequences

module load pear
mkdir mergedNL

for file in trimmed/*NL1*.fastq; do
	file2=$(ls $file | sed s/NL1/NL4/)
	pear -f $file -r $file2 -o mergedNL/"$(basename "$file" .fastq)" -p 0.0001 -v 40	
done
