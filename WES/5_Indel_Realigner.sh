work_dir=/home/jmzeng/snp-calling
reference=/home/jmzeng/ref-database/hg19.fasta   
bwa_dir=$work_dir/resources/apps/bwa-0.7.11
picard_dir=$work_dir/resources/apps/picard-tools-1.119
gatk=$work_dir/resources/apps/gatk/GenomeAnalysisTK.jar
for i in *.dedup.bam
do
echo $i
nohup java -Xmx60g -jar $gatk \
-R $reference -T IndelRealigner \
-I $i \
-targetIntervals ${i%%.*}.intervals -o ${i%%.*}.realgn.bam  1>>${i%%.*}.IndelRealigner.log 2>&1 &
done 
