#!/bin/bash -l
# 
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=rename.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will rename the filename to match the species ID in FileMaker 


for file in consensusITSGood/*.fasta; do
      	mv "$file" "${file%%_ITS1*}.fasta"
done

for file in consensusNLGood/*NL1*.fasta; do
        mv "$file" "${file%%_NL1*}.fasta"
done

for file in consensusITSGood/*.fasta; do 
	mv "$file" $(echo "$file" | sed 's/_/-/1')
done

for file in consensusITSGood/*_*.fasta; do 
	mv "$file" $(echo "$file" | sed 's/_/./1')
done

for file in consensusNLGood/*.fasta; do
        mv "$file" $(echo "$file" | sed 's/_/-/1')
done

for file in consensusNLGood/*_*.fasta; do
        mv "$file" $(echo "$file" | sed 's/_/./1')
done


