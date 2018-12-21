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

# 现在一般是使用 sratoolkit的prefetch函数啦。

for ((i=508;i<=523;i++)) ;do wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP033/SRP033351/SRR1039$i/SRR1039$i.sra;done
