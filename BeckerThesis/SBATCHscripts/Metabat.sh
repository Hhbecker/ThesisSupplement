#!/bin/sh
#SBATCH -o binning.%j.out
#SBATCH -e binning.%j.err
#SBATCH -p highMem
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475
#SBATCH -J binning
#SBATCH -t 12:00:00

## extract contigs
cd megahit_assembly
seqtk comp final.contigs.fa | awk '{if($2 >= 1000) print $1}' > contigs_gt1kb.list
seqtk subseq final.contigs.fa contigs_gt1kb.list > contigs_gt1kb.fasta

## run mapping and sorting bam files
mkdir binning
cd binning
bbwrap.sh \
    ref=../contigs_gt1kb.fasta \
    in1=../../SRR10848475_1.trimmed.fastq.gz \
    in2=../../SRR10848475_2.trimmed.fastq.gz \
    out=SRR7905025.bam \
    t=16 \
    nodisk

samtools sort -O bam -@ 16 SRR10848475.bam > SRR10848475.sorted.bam
rm SRR10848475.bam

## summarize bam files
jgi_summarize_bam_contig_depths \
    --outputDepth depth_min1500.txt \
    --pairedContigs paired_min1500.txt \
    --minContigLength 1500 \
    --minContigDepth 2 *.sorted.bam

## run metabat
metabat2 -i ../contigs_gt1kb.fasta -a depth_min1500.txt -o bins/bin -t 24
