#!/bin/bash
#SBATCH -o phylaqua.%j.out
#SBATCH -e phylaqua.%j.err
#SBATCH -D /lustre/groups/sawgrp/henryb/aqua
#SBATCH -N 1
#SBATCH -J phylaqua
#SBATCH -t 2-00:00:00
#SBATCH -p highThru

phylophlan -i finalGenomes \
    -d phylophlan \
    --diversity low \
    -f supermatrix_aa.cfg
