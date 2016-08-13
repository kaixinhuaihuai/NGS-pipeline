## step5 : alignment to   hg19/ using bowtie2 to do alignment 
##  ~/biosoft/bowtie/bowtie2-2.2.9/bowtie2-build  ~/biosoft/bowtie/hg19_index /hg19.fa  ~/biosoft/bowtie/hg19_index/hg19
## cat >run_bowtie2.sh
ls *.fastq | while read id ; 
## if you do change the fq files by fastx tools, you need to ls *_clean.fq.gz
do  
echo $id
~/biosoft/bowtie/bowtie2-2.2.9/bowtie2 -p 20 -x ~/biosoft/bowtie/hg19_index/hg19 -U $id   \
										-S ${id%%.*}.sam  2>${id%%.*}.align.log; 
## firstly we just keep the high mapping quality reads according to ENCODE project guideline.
samtools view -bhS -q 30  ${id%%.*}.sam > ${id%%.*}.highQuality.bam  
## -F 1548 https://broadinstitute.github.io/picard/explain-flags.html 
samtools sort   ${id%%.*}.highQuality.bam ${id%%.*}.highQuality.sorted  ## prefix for the output   
samtools index ${id%%.*}.highQuality.sorted.bam 

## Then we just keep the unique mapping reads according to the majority tutorial.
grep -v "XS:i:" ${id%%.*}.sam |samtools view -bhS - >${id%%.*}.unique.bam
samtools sort   ${id%%.*}.unique.bam ${id%%.*}.unique.sorted  ## prefix for the output   
samtools index ${id%%.*}.unique.sorted.bam 

done 

#below is the log files for the test data :

# SRR1042593.fastq
# 16902907 reads; of these:
#   16902907 (100.00%) were unpaired; of these:
#   667998 (3.95%) aligned 0 times
# 12467095 (73.76%) aligned exactly 1 time
# 3767814 (22.29%) aligned >1 times
# 96.05% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042594.fastq
# 60609833 reads; of these:
#   60609833 (100.00%) were unpaired; of these:
#   9165487 (15.12%) aligned 0 times
# 39360173 (64.94%) aligned exactly 1 time
# 12084173 (19.94%) aligned >1 times
# 84.88% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042595.fastq
# 14603295 reads; of these:
#   14603295 (100.00%) were unpaired; of these:
#   918028 (6.29%) aligned 0 times
# 10403045 (71.24%) aligned exactly 1 time
# 3282222 (22.48%) aligned >1 times
# 93.71% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042596.fastq
# 65911151 reads; of these:
#   65911151 (100.00%) were unpaired; of these:
#   10561790 (16.02%) aligned 0 times
# 42271498 (64.13%) aligned exactly 1 time
# 13077863 (19.84%) aligned >1 times
# 83.98% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042597.fastq
# 22210858 reads; of these:
#   22210858 (100.00%) were unpaired; of these:
#   1779568 (8.01%) aligned 0 times
# 15815218 (71.20%) aligned exactly 1 time
# 4616072 (20.78%) aligned >1 times
# 91.99% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042598.fastq
# 58068816 reads; of these:
#   58068816 (100.00%) were unpaired; of these:
#   8433671 (14.52%) aligned 0 times
# 37527468 (64.63%) aligned exactly 1 time
# 12107677 (20.85%) aligned >1 times
# 85.48% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042599.fastq
# 24019489 reads; of these:
#   24019489 (100.00%) were unpaired; of these:
#   1411095 (5.87%) aligned 0 times
# 17528479 (72.98%) aligned exactly 1 time
# 5079915 (21.15%) aligned >1 times
# 94.13% overall alignment rate
# [samopen] SAM header is present: 93 sequences.
# SRR1042600.fastq
# 76361026 reads; of these:
#   76361026 (100.00%) were unpaired; of these:
#   8442054 (11.06%) aligned 0 times
# 50918615 (66.68%) aligned exactly 1 time
# 17000357 (22.26%) aligned >1 times
# 88.94% overall alignment rate
# [samopen] SAM header is present: 93 sequences.