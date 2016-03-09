#6.bam2mpipeup.sh
reference=/home/jmzeng/ref-database/hg19.fasta  
for i in *.realgn.bam
do
echo $i
nohup samtools mpileup -f $reference $i 1>${i%%.*}.mpileup.txt 2>${i%%.*}.mpileup.log & 
done
