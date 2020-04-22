#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=fastqc.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#this code will generate several quality plots in html and png format in folder fastqctest for all sequence in folder converted

cat converted/*.fastq > allsequences.fastq

module load fastqc

fastqc -o fastqctest/ allseqeunces.fastq  

