#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=convert.err # update the error file every time 
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This code will convert all ab1 files in a directory names ab1_files to fastq files

module load emboss

rm converted/*.fastq

for file in ab1_files2/*.ab1; do
	seqret -sformat abi -osformat fastq-sanger -auto -stdout -sequence "$file" > converted/"$(basename "$file" .ab1).fastq"
done
