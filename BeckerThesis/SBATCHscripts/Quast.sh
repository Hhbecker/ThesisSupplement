#!/bin/bash
#SBATCH -o quast.%j.out
#SBATCH -e quast.%j.err
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/megahit_assembly
#SBATCH -J Quast
#SBATCH -N 1
#SBATCH -t 4:00:00
#SBATCH -p defq

##  conda activate py37

quast final.contigs.fa -o quast_contigs

##  conda activate base
