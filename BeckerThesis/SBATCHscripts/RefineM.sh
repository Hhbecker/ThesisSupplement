#!/bin/bash
#SBATCH -o refinem.%j.out
#SBATCH -e refinem.%j.err
#SBATCH -p defq
#SBATCH -N 1
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/megahit_assembly
#SBATCH -J ASSM
#SBATCH -t 10:00:00

cd binning/
samtools index -@ 4 SRR10848475.sorted.bam
cd ../

refinem scaffold_stats -c 4 contigs_gt1kb.fasta binning/bins refinem_out binning/*.sorted.bam --genome_ext fa
refinem outliers refinem_out/scaffold_stats.tsv refinem_out
refinem filter_bins binning/bins refinem_out/outliers.tsv filtered_bins --genome_ext fa
