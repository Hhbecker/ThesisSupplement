#!/bin/bash
#SBATCH -o mega.%j.out
#SBATCH -e mega.%j.err
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475
#SBATCH -J MEGA
#SBATCH -N 1
#SBATCH -t 12:00:00
#SBATCH -p defq

megahit \
    -1 /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/SRR10848475_1.trimmed.fastq.gz \
    -2 /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/SRR10848475_2.trimmed.fastq.gz \
    -t 16 \
    -o megahit_assembly
