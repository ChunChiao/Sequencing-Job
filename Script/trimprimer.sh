#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=trimprimer.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#This script will take all fastq files in a folder named converted and quality trim them.

#Please note:  as trimmomatic is updated, the path to the trimmomatic jar file may need to be updated

module load trimmomatic
rm trimprimer/*.fastq
mkdir trimprimer

for file in converted/*ITS1*.fastq; do 
	java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/ITS1primer.fa:14:30:5 
done 

for file in converted/*ITS4*.fastq; do
        java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/ITS4primer.fa:12:30:5 
done

for file in converted/*NL1*.fastq; do
        java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/NL1primer.fa:12:30:5 
done

for file in converted/*NL4*.fastq; do
        java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/NL4primer.fa:12:30:5
done

for file in converted/*ITS1F*.fastq; do
        java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/ITS1Fprimer.fa:12:30:5
done

for file in converted/*ACTHVF*.fastq; do 
	java -jar trimmomatic-0.35.jar SE -phred33 -trimlog trimlog.txt $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/ACTHVFprimer.fa:12:30:5
done 

for file in converted/*ACTHVR*.fastq; do 
	java -jar trimmomatic-0.35.jar SE -phred33 $file trimprimer/"$(basename "$file" .fastq).ptrim.fastq" ILLUMINACLIP:Primer/ACTHVRprimer.fa:12:30:5
done
