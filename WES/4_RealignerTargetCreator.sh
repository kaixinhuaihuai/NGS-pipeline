work_dir=/home/jmzeng/snp-calling
reference=/home/jmzeng/ref-database/hg19.fasta   
bwa_dir=$work_dir/resources/apps/bwa-0.7.11
picard_dir=$work_dir/resources/apps/picard-tools-1.119
gatk=$work_dir/resources/apps/gatk/GenomeAnalysisTK.jar
for i in *.dedup.bam
do
echo $i
nohup java -Xmx60g -jar $gatk \
-R $reference \
-T RealignerTargetCreator \
-I $i -o ${i%%.*}.intervals \
-known /home/ldzeng/EXON/ref/1000G_phase1.indels.hg19.sites.vcf 1>>${i%%.*}.RealignerTargetCreator.log 2>&1 &
done 
