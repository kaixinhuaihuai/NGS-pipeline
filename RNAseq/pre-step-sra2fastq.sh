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

# 下面的代码是告诉大家，如果不会写shell脚本，就只能傻瓜式的替换，其实脚本很简单。

#ls *sra |while read id; do ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3 $id;done
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_untreated	SRR1039508.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Dex		SRR1039509.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Alb		SRR1039510.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Alb_Dex		SRR1039511.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_untreated		SRR1039512.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Dex		SRR1039513.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Alb		SRR1039514.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Alb_Dex		SRR1039515.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_untreated		SRR1039516.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Dex		SRR1039517.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Alb		SRR1039518.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Alb_Dex		SRR1039519.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_untreated		SRR1039520.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Dex		SRR1039521.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Alb		SRR1039522.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Alb_Dex		SRR1039523.sra &
