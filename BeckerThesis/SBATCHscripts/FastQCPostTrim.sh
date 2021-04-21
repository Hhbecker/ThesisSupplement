#!/bin/bash
#SBATCH -o FastqcPostTrim.%j.out
#SBATCH -e FastqcPostTrim.%j.err
#SBATCH -D  /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475
#SBATCH -N 1
#SBATCH -J Fastqc
#SBATCH -t 2:00:00
#SBATCH -p defq


fastqc *.trimmed.fastq.gz
