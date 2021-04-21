#!/bin/bash
#SBATCH -o FastqcPreTrim.%j.out
#SBATCH -e FastqcPreTrim.%j.err
#SBATCH -D  /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475
#SBATCH -N 1
#SBATCH -J Fastqc
#SBATCH -t 2:00:00
#SBATCH -p defq


fastqc *.fastq.gz
