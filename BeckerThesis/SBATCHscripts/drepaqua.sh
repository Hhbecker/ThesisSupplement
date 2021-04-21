#!/bin/bash
#SBATCH -o drepaqua.%j.out
#SBATCH -e drepaqua.%j.err
#SBATCH -D /lustre/groups/sawgrp/henryb/aqua
#SBATCH -J drepaqua
#SBATCH -N 1
#SBATCH -t 4:00:00
#SBATCH -p debug

dRep dereplicate drepGenomes -g aqua_assemblies/*.fna

