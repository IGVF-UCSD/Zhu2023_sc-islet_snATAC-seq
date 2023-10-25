input_file=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/chromap/MM168/aln.bed
outdir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/24Oct23/snapatac2/cellcommander_recipe/MM168
config_file=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_annotation/cellcommander/recipes/config.yaml

cmd="cellcommander recipes \
--input_paths $input_file \
--outdir_path $outdir_path \
--method snapatac2 \
--mode single-sample \
--params_path $config_file"
echo $cmd
eval $cmd
