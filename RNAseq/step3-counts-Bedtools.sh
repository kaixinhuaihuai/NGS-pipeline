## usage: bash bedtools_counts.sh 
## cat  ~/annotation/gencode/v24_GRCH37/gencode.v24lift37.annotation.gtf | \
##	   perl -alne '{next unless $F[2] eq "gene";/gene_name\s\"(.*?)\";/;$geneName=$1;print "$F[0]\t$F[3]\t$F[4]\t$geneName"}' >hg19.gene.bed
nohup bedtools multicov -bams  *sorted.bam  -bed  hg19.gene.bed 1>bedtools_counts.txt  2>bedtools_counts.log & 
