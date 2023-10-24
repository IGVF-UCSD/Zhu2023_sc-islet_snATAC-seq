#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_processing/slurm_logs/%x.%A_%a.out
#SBATCH --error=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_processing/slurm_logs/%x.%A_%a.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=14:00:00
#SBATCH --array=1-5%5

#####
# USAGE:
# sbatch --job-name=Zhu2023_sc-islet_snATAC-seq_run_chromap SLURM_ARRAY_run_chromap.sh
#####

# Start time
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Activate the env with chromap
source activate /cellar/users/aklie/opt/miniconda3/envs/pipelines

# Set file paths
fastq_dir=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/fastq/04Jul23
output_dir=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap
ref_dir=/cellar/users/aklie/data/ref/genomes/hg38
bc_whitelist=/cellar/users/aklie/data/ref/bc_whitelists/737K-cratac-v1.rc.txt

# Samples
experiment_accessions=(
    'SRX15207297' 
    'SRX15207298' 
    'SRX15207299' 
    'SRX15207300'
    'SRX15207301'
)
sample_ids=(
    'MM129' 
    'MM157' 
    'MM166' 
    'MM168' 
    'MM290'
)
input_dir=$fastq_dir/${experiment_accessions[$SLURM_ARRAY_TASK_ID-1]}
sample=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}
read1=$(ls $input_dir/*_1.fastq.gz)
read2=$(ls $input_dir/*_3.fastq.gz)
barcode=$(ls $input_dir/*_2.fastq.gz)

# Make output directory if doesn't exist
if [ ! -d $output_dir/$sample ]; then
    mkdir -p $output_dir/$sample
fi

# Run the command
cmd="chromap --preset atac \
--drop-repetitive-reads 4 \
-q 0 \
-x $ref_dir/index \
-r $ref_dir/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
-1 $read1 \
-2 $read2 \
-o $output_dir/$sample/aln.bed \
-b $barcode \
--barcode-whitelist $bc_whitelist \
--num-threads 12"

echo -e "Running:\n $cmd\n"
eval $cmd

# End time
date
