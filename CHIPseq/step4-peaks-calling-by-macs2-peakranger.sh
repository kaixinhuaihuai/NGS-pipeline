
nohup time ~/.local/bin/macs2 callpeak -c SRR1042594.sorted.bam -t SRR1042593.sorted.bam -f BAM -B -g hs -n Xu_MUT_rep1 2>Xu_MUT_rep1.masc2.log &
nohup time ~/.local/bin/macs2 callpeak -c SRR1042596.sorted.bam -t SRR1042595.sorted.bam -f BAM -B -g hs -n Xu_MUT_rep2 2>Xu_MUT_rep2.masc2.log &
nohup time ~/.local/bin/macs2 callpeak -c SRR1042598.sorted.bam -t SRR1042597.sorted.bam -f BAM -B -g hs -n Xu_WT_rep1  2>Xu_WT_rep1.masc2.log &
nohup time ~/.local/bin/macs2 callpeak -c SRR1042600.sorted.bam -t SRR1042599.sorted.bam -f BAM -B -g hs -n Xu_WT_rep2  2>Xu_WT_rep2.masc2.log &

~/biosoft/PeakRanger/bin/peakranger ccat --format bam SRR1042594.sorted.bam SRR1042593.sorted.bam  \
Xu_MUT_rep1_ccat_report --report --gene_annot_file hg19refGene.txt -q 0.05  -t 4  



# macs2 callpeak -t TF_1.bam -c Input.bam -n mypeaks
# We used the following options:
#   -t: This is the only required parameter for MACS, refers to the name of the file with the ChIP-seq data
# -c: The control or mock data file
# -n: The name string of the experiment
# MAC2 creates 4 files (mypeaks peaks.narrowPeak, mypeaks summits.bed, mypeaks peaks.xls and mypeaks model.r)

# you need to make sure which data is input and which is IP,the metadata is below:

# GSM1278641	Xu_MUT_rep1_BAF155_MUT	SRR1042593
# GSM1278642	Xu_MUT_rep1_Input	SRR1042594
# GSM1278643	Xu_MUT_rep2_BAF155_MUT	SRR1042595
# GSM1278644	Xu_MUT_rep2_Input	SRR1042596
# GSM1278645	Xu_WT_rep1_BAF155	SRR1042597
# GSM1278646	Xu_WT_rep1_Input	SRR1042598
# GSM1278647	Xu_WT_rep2_BAF155	SRR1042599
# GSM1278648	Xu_WT_rep2_Input	SRR1042600
# 
# 848M Jun 28 14:31 SRR1042593.bam
# 2.7G Jun 28 14:52 SRR1042594.bam
# 716M Jun 28 14:58 SRR1042595.bam
# 2.9G Jun 28 15:20 SRR1042596.bam
# 1.1G Jun 28 15:28 SRR1042597.bam
# 2.6G Jun 28 15:48 SRR1042598.bam
# 1.2G Jun 28 15:58 SRR1042599.bam
# 3.5G Jun 28 16:26 SRR1042600.bam
