#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_annotation/cellcommander/slurm_logs/%x.%A_%a.out
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=02-00:00:00
#SBATCH --array=1-1%1

#####
# USAGE:
# sbatch --job-name=igvf_sc-islet_10X-Multiome_snapatac2_single-sample snapatac2_single-sample.sh
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configuring env (choose either singularity or conda)
source activate /cellar/users/aklie/opt/miniconda3/envs/cellcommander

indir_paths=(
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM129'
    #'/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM157'
    #'/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM166'
    #'/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM168'
    #'/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM290'
)
sample_ids=(
    'MM129'
    #'MM157'
    #'MM166'
    #'MM168'
    #'MM290'
)
indir_path=${indir_paths[$SLURM_ARRAY_TASK_ID-1]}
sample_id=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}
outdir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/25Oct23/snapatac2/cellcommander_recipe/${sample_id}
params_file=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_annotation/cellcommander/recipes/snapatac2_single-sample.yaml

# If output dir does not exist, create it
if [ ! -d $outdir_path ]; then
    mkdir -p $outdir_path
fi

cmd="cellcommander recipes \
--input_paths $indir_path/aln.bed \
--outdir_path $outdir_path \
--method snapatac2 \
--mode single-sample \
--params_path $params_file"
echo -e "Running command:\n$cmd\n"
eval $cmd

date
