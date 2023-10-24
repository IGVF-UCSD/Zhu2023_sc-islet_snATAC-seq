#!/bin/bash
#SBATCH --account carter-gpu
#SBATCH --partition carter-gpu
#SBATCH --gpus=1
#SBATCH --output=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_annotation/scbasset/slurm_logs/%x.%A.out
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=05:00:00

#####
# USAGE:
# sbatch --job-name=igvf_sc-islet_10X-Multiome_scbasset 2_train_scbasset.sh /path/to/input/folder /path/to/output/folder
#####


# Env
source activate scbasset
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cellar/users/aklie/opt/miniconda3/envs/scbasset/lib

# Check if gpu is visible to tensorflow
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Run scBasset
python /cellar/users/aklie/opt/ml4gland/scBasset/bin/scbasset_train.py \
    --input_folder /cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/24Oct23/scbasset/MM168 \
    --out_path /cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/24Oct23/scbasset/MM168/model
     