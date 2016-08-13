## usage: nohup bash align_hisat2.sh sample.list  1>align_hisat2.log 2>&1 & 
## firstly,you need to create a junction files like below:
## ~/biosoft/HISAT/current/extract_splice_sites.py ~/annotation/gencode/v24_GRCH37/gencode.v24lift37.annotation.gtf >~/biosoft/HISAT/hg19/gtf/human_splicesites.txt
while read id   
###		The configue files just contain the sample name. 
### 	N61311_Alb	N61311_Alb_1.fastq.gz	N61311_Alb_2.fastq.gz
do  
echo $id
~/biosoft/HISAT/current/hisat2  -p 20 \
--known-splicesite-infile   ~/biosoft/HISAT/hg19/gtf/human_splicesites.txt \
-x ~/biosoft/HISAT/hg19/genome \
-1 ${id}_1.fastq.gz -2 ${id}_2.fastq.gz  \
-S ${id}.hisat.sam  2>${id}.hisat.align.log; 
										
samtools view -bhS -q 30  ${id}.hisat.sam > ${id}.hisat.bam   
samtools sort   ${id}.hisat.bam ${id}.hisat.sorted  ## prefix for the output   
samtools index ${id}.hisat.sorted.bam  
done <$1 