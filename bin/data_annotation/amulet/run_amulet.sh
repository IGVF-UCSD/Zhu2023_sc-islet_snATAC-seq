outdir_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/annotation/26Oct23/amulet/MM168

# If output dir does not exist, create it
if [ ! -d $outdir_path ]; then
    mkdir -p $outdir_path
fi

cmd="/cellar/users/aklie/opt/AMULET_SourceAndScripts/ATACDoubletDetector.sh \
--bambc CB \
--bcidx 0 \
--cellidx 2 \
--iscellidx 3 \
/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM168/outs/possorted_bam.bam \
/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM168/outs/singlecell.csv \
/cellar/users/aklie/opt/AMULET_SourceAndScripts/human_autosomes.txt \
/cellar/users/aklie/opt/AMULET_SourceAndScripts/RepeatFilterFiles/blacklist_repeats_segdups_rmsk_hg38.bed \
$outdir_path \
/cellar/users/aklie/opt/AMULET_SourceAndScripts"
echo $cmd
eval $cmd
