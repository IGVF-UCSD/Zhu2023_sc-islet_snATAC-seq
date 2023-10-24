indir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM129/outs
outdir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/24Oct23/cellcommander/MM129/atac
metadata_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM129/outs/singlecell.csv

cmd="cellcommander qc \
--input_h5_path $indir_path/raw_peak_bc_matrix.h5 \
--outdir_path $outdir_path/qc \
--output_prefix threshold_qc \
--metadata_path $metadata_path \
--metadata_source cellranger \
--mode atac \
--filtering_strategy threshold \
--total_counts_low 5000 \
--total_counts_hi 50000 \
--n_features_low 750 \
--n_for_ns_calc 10000 \
--ns_hi 1.5 \
--n_tss 3000 \
--tss_low 5 \
--tss_hi 50 \
--random-state 1234"
echo -e "Running:\n $cmd\n"
#eval $cmd