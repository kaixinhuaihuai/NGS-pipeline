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

ls *.fastq  *fq * fq.gz | while read id ; do ~/biosoft/fastqc/FastQC/fastqc $id;done 
mkdir QC_results 
mv *zip *html QC_results 

# 现在一般会使用 multiqc可视化一下这些报告。