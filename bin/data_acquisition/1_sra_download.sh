#! /bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/igvf/beta_cell_networks/download/out/%x.%A.out
#SBATCH --error=/cellar/users/aklie/data/igvf/beta_cell_networks/download/err/%x.%A.err
#SBATCH --mem=100G
#SBATCH -n 64
#SBATCH -t 14-00:00:00

# USAGE: sbatch --job-name=Zhu2023_sc-islet_snATAC-seq_fastq-dump 1_sra_download.sh

python 1_sra_download.py