#!/bin/bash
#SBATCH -o aquadown.%j.out
#SBATCH -e aquadown.%j.err
#SBATCH -p debug
#SBATCH -D /lustre/groups/sawgrp/henryb/aqua
#SBATCH -J aquadown
#SBATCH -t 4:00:00

genbank_get_genomes_by_taxon.py -o aqua_assemblies -v -t 200783 -l aqua_downloads.log --email beckstar44@gmail.com
