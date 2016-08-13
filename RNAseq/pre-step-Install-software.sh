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

mkdir -p ~/annotation/gencode/v24_GRCH37
cd ~/annotation/gencode/v24_GRCH37
wget -c -r -np -nd -k -L ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_24/GRCh37_mapping

cd ~/biosoft
# http://www.broadinstitute.org/cancer/cga/rnaseqc_run
# http://www.broadinstitute.org/cancer/cga/rnaseqc_download
mkdir RNA-SeQC  &&  cd RNA-SeQC 
#### readme: http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/RNA-SeQC_Help_v1.1.2.pdf
wget http://www.broadinstitute.org/cancer/cga/tools/rnaseqc/RNA-SeQC_v1.1.8.jar 
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/ThousandReads.bam
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/gencode.v7.annotation_goodContig.gtf.gz
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/Homo_sapiens_assembly19.fasta.gz
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/Homo_sapiens_assembly19.other.tar.gz
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/gencode.v7.gc.txt
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/rnaseqc/rRNA.tar.gz


#TopHat+Cufflinks+ pipeline

## Download and install TopHat 
# https://ccb.jhu.edu/software/tophat/index.shtml
cd ~/biosoft
mkdir TopHat  &&  cd TopHat 
#### readme: https://ccb.jhu.edu/software/tophat/manual.shtml
wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
tar xzvf tophat-2.1.1.Linux_x86_64.tar.gz 
ln -s tophat-2.1.1.Linux_x86_64 current 

# ~/biosoft/TopHat/current/tophat2

## Download and install Cufflinks 
#  http://cole-trapnell-lab.github.io/cufflinks/
cd ~/biosoft
mkdir Cufflinks  &&  cd Cufflinks 
#### readme: http://cole-trapnell-lab.github.io/cufflinks/manual/
#### install:http://cole-trapnell-lab.github.io/cufflinks/install/
wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
tar xzvf cufflinks-2.2.1.Linux_x86_64.tar.gz 
ln -s cufflinks-2.2.1.Linux_x86_64 current
~/biosoft/Cufflinks/current/cufflinks

#HISAT-Stringtie2-Ballgown pipeline

## Download and install HISAT 
# https://ccb.jhu.edu/software/hisat2/index.shtml
cd ~/biosoft
mkdir HISAT  &&  cd HISAT 
#### readme: https://ccb.jhu.edu/software/hisat2/manual.shtml
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.4-Linux_x86_64.zip
unzip hisat2-2.0.4-Linux_x86_64.zip
ln -s hisat2-2.0.4  current 
## ~/biosoft/HISAT/current/hisat2-build
## ~/biosoft/HISAT/current/hisat2  
nohup wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data/hg19.tar.gz  &
tar zxvf hg19.tar.gz

## Download and install StringTie
## https://ccb.jhu.edu/software/stringtie/  ## https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual
cd ~/biosoft
mkdir StringTie &&  cd StringTie 
wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.2.3.Linux_x86_64.tar.gz 
tar zxvf  stringtie-1.2.3.Linux_x86_64.tar.gz
ln -s stringtie-1.2.3.Linux_x86_64 current
# ~/biosoft/StringTie/current/stringtie

## CummeRbund  ballgown  ( R - bioconductor packges: )
## http://compbio.mit.edu/cummeRbund/
## https://github.com/alyssafrazee/ballgown
## ## source("http://bioconductor.org/biocLite.R")
## ## biocLite("ballgown")
## ## biocLite("CummeRbund")

##　RSEM+HTseq+Bedtools 　https://github.com/bli25ucb/RSEM_tutorial　　　

## Download and install 　RSEM
## http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html
## http://deweylab.biostat.wisc.edu/rsem/README.html
## https://github.com/bli25ucb/RSEM_tutorial

cd ~/biosoft
mkdir RSEM &&  cd RSEM 
wget https://codeload.github.com/deweylab/RSEM/tar.gz/v1.2.31
mv v1.2.31  RSEM.v1.2.31.tar.gz 
tar zxvf RSEM.v1.2.31.tar.gz  

## Download and install HTSeq  
## http://www-huber.embl.de/users/anders/HTSeq/doc/overview.html
## https://pypi.python.org/pypi/HTSeq
cd ~/biosoft
mkdir HTSeq &&  cd HTSeq
wget  https://pypi.python.org/packages/72/0f/566afae6c149762af301a19686cd5fd1876deb2b48d09546dbd5caebbb78/HTSeq-0.6.1.tar.gz 
tar zxvf HTSeq-0.6.1.tar.gz
cd HTSeq-0.6.1
python setup.py install --user 
## ~/.local/bin/htseq-count  --help
## ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M1/
## http://hgdownload-test.cse.ucsc.edu/goldenPath/mm10/liftOver/
## GRCm38/mm10 (Dec, 2011) 
## ls *bam |while read id;do ( ~/.local/bin/htseq-count  -f bam  $id   genecode/mm9/gencode.vM1.annotation.gtf.gz  1>${id%%.*}.gene.counts ) ;done 
## ls *bam |while read id;do ( ~/.local/bin/htseq-count  -f bam -i exon_id  $id   genecode/mm9/gencode.vM1.annotation.gtf.gz  1>${id%%.*}.exon.counts ) ;done

## Download and install kallisto
## https://pachterlab.github.io/kallisto/starting
cd ~/biosoft
mkdir kallisto &&  cd kallisto 
wget https://github.com/pachterlab/kallisto/releases/download/v0.43.0/kallisto_linux-v0.43.0.tar.gz
tar zxvf  

## Download and install Sailfish
## http://www.cs.cmu.edu/~ckingsf/software/sailfish/  ## 
cd ~/biosoft
mkdir Sailfish &&  cd Sailfish 
wget   https://github.com/kingsfordgroup/sailfish/releases/download/v0.9.2/SailfishBeta-0.9.2_DebianSqueeze.tar.gz 
tar zxvf  

## Download and install salmon
## http://salmon.readthedocs.io/en/latest/salmon.html ## 
cd ~/biosoft
mkdir salmon &&  cd salmon 
## https://github.com/COMBINE-lab/salmon
tar zxvf  

