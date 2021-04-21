#!/bin/bash
#SBATCH -o trim.%j.out
#SBATCH -e trim.%j.err
#SBATCH -D  /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/
#SBATCH -N 1
#SBATCH -J TRIM
#SBATCH -t 2:00:00
#SBATCH -p defq

bbduk.sh ktrim=r ordered minlen=50 mink=11 rcomp=f k=21 ow=t zl=4 \
    qtrim=rl trimq=20 \
    in1=SRR10848475_1.fastq.gz \
    in2=SRR10848475_2.fastq.gz \
    ref=/CCAS/home/hhbecker/adapters.fa \
    out1=SRR10848475_1.trimmed.fastq.gz \
    out2=SRR10848475_2.trimmed.fastq.gz
