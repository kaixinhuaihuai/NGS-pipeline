#!/bin/bash

### ---------------
###
### Create: Jianming Zeng
### Date: 2016-8-14
### CAFS/SUSTC/Eli Lilly/University of Macau
### Update Log: 2016-8-14  add reference + annotation for human hg19 version
### Update Log: 2016-8-12  add HISAT-Stringtie2-Ballgown pipeline
### Update Log: 2016-7-16  add TopHat+Cufflinks+HTseq pipeline
### Update Log: 2016-7-15  add bowtie2+RSEM+RNA-SeQC pipeline 
###
### ---------------

# 现在一般不选择这个质控报告，我会推荐 qualimap软件

RNASeQC_bin=~/biosoft/RNA-SeQC
java -jar $RNASeQC_bin/RNA-SeQC_v1.1.8.jar -n 1000 -s "TestId|ThousandReads.bam|TestDesc" \
-t $RNASeQC_bin/gencode.v7.annotation_goodContig.gtf \
-r $RNASeQC_bin/Homo_sapiens_assembly19.fasta \
-strat gc \
-gc $RNASeQC_bin/gencode.v7.gc.txt \
-BWArRNA $RNASeQC_bin/human_all_rRNA.fasta \
-o ./testReport/ 

## -s	Sample File (text-delimited description of samples and their bams).
## -n <arg>                   Number of top transcripts to use.
