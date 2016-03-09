#10. Call SNPs using Unified Genotyper
work_dir=/home/jmzeng/snp-calling
reference=/home/jmzeng/ref-database/hg19.fasta   
bwa_dir=$work_dir/resources/apps/bwa-0.7.11
picard_dir=$work_dir/resources/apps/picard-tools-1.119
gatk=$work_dir/resources/apps/gatk/GenomeAnalysisTK.jar
for i in *.realgn.bam
do
echo $i 
java -Xmx60g -jar $gatk \
-T UnifiedGenotyper -R $reference \
-I $i -o ${i%%.*}.gatk.UG.vcf \
   -stand_call_conf 30.0 \
   -stand_emit_conf 0 \
   -glm BOTH \
   -rf BadCigar 
done 
