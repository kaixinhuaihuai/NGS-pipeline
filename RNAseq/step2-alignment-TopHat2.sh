## usage: nohup bash align_tophat2.sh sample.list  1>align_tophat2.log 2>&1 & 
while read id   
###		The configue files just contain the sample name. 
### 	N61311_Alb	N61311_Alb_1.fastq.gz	N61311_Alb_2.fastq.gz
do  
echo $id
~/biosoft/TopHat/current/tophat2  -p 20  \
-G ~/annotation/gencode/v24_GRCH37/gencode.v24lift37.annotation.gtf   \
-o  tophat_results/$id   \
~/biosoft/bowtie/hg19_index/hg19  ${id}_1.fastq.gz   ${id}_2.fastq.gz   
done <$1 