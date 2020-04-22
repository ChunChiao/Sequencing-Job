#!/bin/bash -l
#
#SBATCH --mail-user=ccyyang@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --error=qual_checkstep2.err
#SBATCH --partition=med
#SBATCH --account=adamgrp


cat converted/*.fastq > allsequences.fastq

module load perlbrew fastx 

fastx_quality_stats -i allsequences.fastq -o qualstats.txt

fastq_quality_boxplot_graph.sh -i qualstats.txt -o qualstats_graph.png
 
