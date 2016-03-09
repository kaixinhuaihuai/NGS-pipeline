#7.snp-calling by bcftools
reference=/home/jmzeng/ref-database/hg19.fasta  
for i in *.realgn.bam
do
echo $i
samtools mpileup -guSDf  $reference  $i | bcftools view -cvNg - > ${i%%.*}.bcftools.vcf
done 
