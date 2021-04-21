#!/bin/bash
#SBATCH -o checkm.%j.out
#SBATCH -e checkm.%j.err
#SBATCH -p defq
#SBATCH -N 1
#SBATCH -D /lustre/groups/sawgrp/henryb/MushroomData/FirstRunSRR10848475/megahit_assembly
#SBATCH -J CHECKM
#SBATCH -t 10:00:00


checkm lineage_wf -f CheckM.txt -t 24 -x fa filtered_bins checkm_out
