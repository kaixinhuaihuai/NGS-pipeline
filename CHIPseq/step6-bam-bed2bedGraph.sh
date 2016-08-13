
#	sam/bam/bed --> bedGraph 
#	http://bedtools.readthedocs.io/en/latest/content/tools/bamtobed.html
#	http://bedtools.readthedocs.io/en/latest/content/tools/genomecov.html 
bedtools getfasta -fi ~/biosoft/bowtie/hg19_index/hg19.fa  -bed ../macs14_results/highQuality_summits.bed  -fo highQuality.fa
bedtools getfasta -fi ~/biosoft/bowtie/hg19_index/hg19.fa  -bed ../macs14_results/highQuality_peaks.bed  -fo highQuality.fa

