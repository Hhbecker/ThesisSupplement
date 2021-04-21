#!/bin/bash
#SBATCH -o gtdb.%j.out
#SBATCH -e gtdb.%j.err
#SBATCH -p debug
#SBATCH -N 1
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/megahit_assembly
#SBATCH -J GTDBTK
#SBATCH -t 4:00:00

gtdbtk classify_wf --genome_dir filtered_bins/ --out_dir gtdb-tk_out --cpus 24 -x fa
