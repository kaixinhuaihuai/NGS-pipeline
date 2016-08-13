## usage: nohup bash align_bowtie2.sh config  1>align_bowtie2.log 2>&1 & 
while read id   
###		The configue files just contain the sample name. 
### 	N61311_Alb	N61311_Alb_1.fastq.gz	N61311_Alb_2.fastq.gz
do  
echo $id
~/biosoft/bowtie/bowtie2-2.2.9/bowtie2 -p 20 -x ~/biosoft/bowtie/hg19_index/hg19 -1 ${id}_1.fastq.gz -2 ${id}_2.fastq.gz \
										-S ${id}.bowtie2.sam  2>${id}.bowtie2.align.log; 
										
samtools view -bhS -q 30  ${id}.bowtie2.sam > ${id}.bowtie2.bam   
samtools sort   ${id}.bowtie2.bam ${id}.bowtie2.sorted  ## prefix for the output   
samtools index ${id}.bowtie2.sorted.bam  
done <$1 