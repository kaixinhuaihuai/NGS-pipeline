#11.snp-calling by varscan
for i in *.mpileup.txt
do
echo $i
java -jar  /home/jmzeng/bio-soft/VarScan.v2.3.8.jar  mpileup2snp   $i  --output-vcf 1  \
1>${i%%.*}.varscan.snp.vcf   2>${i%%.*}.varscan.snp.log 
java -jar  /home/jmzeng/bio-soft/VarScan.v2.3.8.jar  mpileup2indel $i  --output-vcf 1  \
1>${i%%.*}.varscan.Indel.vcf 2>${i%%.*}.varscan.Indel.vcf 
done 
