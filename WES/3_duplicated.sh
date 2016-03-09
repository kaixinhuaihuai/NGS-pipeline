work_dir=/home/jmzeng/snp-calling
reference=/home/jmzeng/ref-database/hg19.fasta   
bwa_dir=$work_dir/resources/apps/bwa-0.7.11
picard_dir=$work_dir/resources/apps/picard-tools-1.119
for i in *.sorted.bam
do
echo $i
nohup java  -Xmx60g  -jar $picard_dir/MarkDuplicates.jar \
CREATE_INDEX=true REMOVE_DUPLICATES=True \
ASSUME_SORTED=True VALIDATION_STRINGENCY=LENIENT  \
I=$i OUTPUT=${i%%.*}.dedup.bam METRICS_FILE=tmp.metrics 1>>${i%%.*}.MarkDuplicates.log 2>&1 &
done 
