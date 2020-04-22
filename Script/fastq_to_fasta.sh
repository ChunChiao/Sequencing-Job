#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=convert_q_to_a.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This code will convert all ab1 files in a directory names ab1_files to fastq files

for file in mergedITS/*.assembled.fastq; do
	sed -n '1~4s/^@/>/p;2~4p' $file > consensus/"$(basename -a -s .trim.assembled.fastq "$file")ITSconsensus.fasta"
done

for file in mergedNL/*.assembled.fastq; do
	sed -n '1~4s/^@/>/p;2~4p' $file > consensus/"$(basename -a -s .trim.assembled.fastq "$file")NLconsensus.fasta"
done
