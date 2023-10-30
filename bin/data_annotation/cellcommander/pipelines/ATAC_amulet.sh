#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_annotation/cellcommander/slurm_logs/%x.%A_%a.out
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=02-00:00:00
#SBATCH --array=1-5%5

#####
# USAGE:
# sbatch --job-name=igvf_sc-islet_10X-Multiome_ATAC_pipeline ATAC.sh
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configuring env (choose either singularity or conda)
source activate /cellar/users/aklie/opt/miniconda3/envs/cellcommander

indir_paths=(
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM129/outs'
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM157/outs'
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM166/outs'
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM168/outs'
    '/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM290/outs'
)
sample_ids=(
    'MM129'
    'MM157'
    'MM166'
    'MM168'
    'MM290'
)
indir_path=${indir_paths[$SLURM_ARRAY_TASK_ID-1]}
sample_id=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}
outdir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/24Oct23/cellcommander/${sample_id}

# Step 2 -- Detect doublets
echo -e "Running detect doublets\n"
cmd="cellcommander detect-doublets \
--input_h5ad_path $outdir_path/threshold_qc/threshold_qc.h5ad \
--outdir_path $outdir_path/detect_doublets \
--output_prefix amulet_only \
--method amulet"
echo -e "Running:\n $cmd\n"
eval $cmd
echo -e "Done with step 2\n"

date
