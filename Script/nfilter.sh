#!/bin/bash -l
# 
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=nfilter.err
#SBATCH --partition=med
#SBATCH --account=adamgrp

#filter out sequences with more than 1% N bases  

mkdir consensusITSGood consensusITSBad
mkdir consensusNLGood consensusNLBad
mkdir consensusACTHVGood consensusACTHVBad

for file in mergedITS/*.assembled.fastq; do
        perl PRINSEQ/prinseq-lite.pl -fastq $file -ns_max_p 0 -out_format 1 -out_good consensusITSGood/"$(basename $file .assembled.fastq).ITSconsensus" -out_bad consensusITSBad/"$(basename $file .assembled.fastq).ITSconsensus"
done

for file in mergedNL/*.assembled.fastq; do
        perl PRINSEQ/prinseq-lite.pl -fastq $file -ns_max_p 0 -out_format 1 -out_good consensusNLGood/"$(basename $file .assembled.fastq).NLconsensus" -out_bad consensusNLBad/"$(basename $file .assembled.fastq).NLconsensus"
done

for file in mergedACTHV/*consensus.fasta; do
        perl PRINSEQ/prinseq-lite.pl -fasta $file -ns_max_p 3 -out_format 1 -out_good consensusACTHVGood/"$(basename $file consensus.fastq).ACTHVconsensus" -out_bad consensusACTHVBad/"$(basename $file consensus.fastq).ACTHVconsensus"
done

