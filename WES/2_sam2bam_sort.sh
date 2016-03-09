work_dir=/home/jmzeng/snp-calling
reference=/home/jmzeng/ref-database/hg19.fasta   
bwa_dir=$work_dir/resources/apps/bwa-0.7.11
picard_dir=$work_dir/resources/apps/picard-tools-1.119
for i in *sam
do
echo $i
echo ${i%.*}.sorted.bam
nohup java  -Xmx60g  -jar $picard_dir/AddOrReplaceReadGroups.jar  \
I=$i \
O=${i%.*}.sorted.bam  \
SORT_ORDER=coordinate \
CREATE_INDEX=true \
RGID=${i%.*} \
RGLB="pe" \
RGPU="HiSeq-2000" \
RGSM=${i%.*} \
RGCN="Human Genetics of Infectious Disease" \
RGDS=hg19 \
RGPL=illumina \
VALIDATION_STRINGENCY=SILENT >> ${i%.*}.AddOrReplaceReadGroups.log 2>&1 &
done 
