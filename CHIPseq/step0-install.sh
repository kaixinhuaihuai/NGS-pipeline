#!/bin/bash

### ---------------
###
### Create: Jianming Zeng
### Date: 2016-8-14
### CAFS/SUSTC/Eli Lilly/University of Macau
### Update Log: 2016-8-14  add reference + annotation for human/mouse  mm9/hg19 version
### Update Log: 2016-8-12  add sratoolkit/weblogo/fastx_toolkit_0.0.13/fastqc/bowtie2/bwa/
### Update Log: 2016-7-16  add MACS2/HOMER/QuEST/mm9/hg19/bedtools/
### Update Log: 2016-7-15  add PeakRanger/blat/Ghostscript/weblogo/SWEMBL/SISSRs/CEAS
###
### --------------- 


## http://compbio.cs.toronto.edu/shrimp/
cd ~/biosoft
mkdir SHRiMP &&  cd SHRiMP
wget http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_2_2_3.lx26.x86_64.tar.gz 
tar zxvf SHRiMP_2_2_3.lx26.x86_64.tar.gz 
cd SHRiMP_2_2_3
export SHRIMP_FOLDER=$PWD

## http://compbio.cs.toronto.edu/shrimp/README
cd ~/biosoft/SHRiMP/SHRiMP_2_2_3 
export SHRIMP_FOLDER=$PWD
cd -
## memory requirements: 3.0G x 4 x 4 =  48GB of RAM . I don't need to split the hg19.fa  
$SHRIMP_FOLDER/bin/gmapper-cs  tmp.fq \
~/biosoft/bowtie/hg19_index/hg19.fa  \
-N 20  -E -h 80% 1>tmp.map.out 2>tmp.map.log 
## -E : Enable SAM output.
## -N : Use multiple threads 
## -h 80% : Set the threshold score for a hit to 80% of the maximum possible score. 

## http://samstat.sourceforge.net/
cd ~/biosoft
mkdir SAMStat &&  cd SAMStat
wget http://nchc.dl.sourceforge.net/project/samstat/samstat-1.5.1.tar.gz
tar zxvf samstat-1.5.1.tar.gz 
./configure --prefix=/home/jmzeng/my-bin
make 
make install  
~/my-bin/bin/samstat  -h

## Download and install BWA
cd ~/biosoft
mkdir bwa &&  cd bwa
#http://sourceforge.net/projects/bio-bwa/files/
wget https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.15.tar.bz2 
tar xvfj bwa-0.7.12.tar.bz2 # x extracts, v is verbose (details of what it is doing), f skips prompting for each individual file, and j tells it to unzip .bz2 files
cd bwa-0.7.12
make
export PATH=$PATH:/path/to/bwa-0.7.12 # Add bwa to your PATH by editing ~/.bashrc file (or .bash_profile or .profile file)
# /path/to/ is an placeholder. Replace with real path to BWA on your machine
source ~/.bashrc
# bwa index [-a bwtsw|is] index_prefix reference.fasta
# ~/biosoft/bwa/bwa-0.7.15/bwa
cd ~/biosoft/bwa 
mkdir hg19_index &&  cd hg19_index
~/biosoft/bwa/bwa-0.7.15/bwa index -p hg19bwaidx -a bwtsw ~/biosoft/bowtie/hg19_index/hg19.fa 
# -p index name (change this to whatever you want)
# -a index algorithm (bwtsw for long genomes and is for short genomes)
 
cd ~/biosoft/bwa 
mkdir mm10_index &&  cd mm10_index
~/biosoft/bwa/bwa-0.7.15/bwa index -p mm10bwaidx -a bwtsw ~/biosoft/bowtie/hg19_index/hg19.fa 
wget http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz  
tar xzvf chromFa.tar.gz
cat *fa >mm10_ucsc.fasta
rm *fa 
~/biosoft/bwa/bwa-0.7.15/bwa index -p mm10bwaidx -a bwtsw  mm10_ucsc.fasta

## Download and install sratoolkit
## http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software
## http://www.ncbi.nlm.nih.gov/books/NBK158900/
cd ~/biosoft
mkdir sratoolkit &&  cd sratoolkit
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.6.3/sratoolkit.2.6.3-centos_linux64.tar.gz
##
##  Length: 63453761 (61M) [application/x-gzip]
##  Saving to: "sratoolkit.2.6.3-centos_linux64.tar.gz"
tar zxvf sratoolkit.2.6.3-centos_linux64.tar.gz
~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastdump -h

## Download and install bedtools
cd ~/biosoft
mkdir bedtools &&  cd bedtools
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
## Length: 19581105 (19M) [application/octet-stream] 
tar -zxvf bedtools-2.25.0.tar.gz
cd bedtools2
make
~/biosoft/bedtools/bedtools2/bin/


## Download and install PeakRanger
cd ~/biosoft
mkdir PeakRanger &&  cd PeakRanger
wget https://sourceforge.net/projects/ranger/files/PeakRanger-1.18-Linux-x86_64.zip 
## Length: 1517587 (1.4M) [application/octet-stream]
unzip PeakRanger-1.18-Linux-x86_64.zip
~/biosoft/PeakRanger/bin/peakranger -h

## Download and install bowtie
cd ~/biosoft
mkdir bowtie &&  cd bowtie
wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.9/bowtie2-2.2.9-linux-x86_64.zip 
#Length: 27073243 (26M) [application/octet-stream]
#Saving to: "download"   ## I made a mistake here for downloading the bowtie2 
mv download  bowtie2-2.2.9-linux-x86_64.zip
unzip bowtie2-2.2.9-linux-x86_64.zip
 
mkdir -p ~/biosoft/bowtie/hg19_index 
cd ~/biosoft/bowtie/hg19_index

# download hg19 chromosome fasta files
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz
# unzip and concatenate chromosome and contig fasta files
tar zvfx chromFa.tar.gz
cat *.fa > hg19.fa
rm chr*.fa
##  ~/biosoft/bowtie/bowtie2-2.2.9/bowtie2-build  ~/biosoft/bowtie/hg19_index/hg19.fa  ~/biosoft/bowtie/hg19_index/hg19


## Download and install BWA
cd ~/biosoft
mkdir bwa &&  cd bwa
http://sourceforge.net/projects/bio-bwa/files/
tar xvfj bwa-0.7.12.tar.bz2 # x extracts, v is verbose (details of what it is doing), f skips prompting for each individual file, and j tells it to unzip .bz2 files
cd bwa-0.7.12
make
export PATH=$PATH:/path/to/bwa-0.7.12 # Add bwa to your PATH by editing ~/.bashrc file (or .bash_profile or .profile file)
# /path/to/ is an placeholder. Replace with real path to BWA on your machine
source ~/.bashrc
# bwa index [-a bwtsw|is] index_prefix reference.fasta
bwa index -p hg19bwaidx -a bwtsw ~/biosoft/bowtie/hg19_index/hg19.fa 
# -p index name (change this to whatever you want)
# -a index algorithm (bwtsw for long genomes and is for short genomes)


## Download and install macs2  
## // https://pypi.python.org/pypi/MACS2/
cd ~/biosoft
mkdir macs2 &&  cd macs2
## https://pypi.python.org/packages/9f/99/a8ac96b357f6b0a6f559fe0f5a81bcae12b98579551620ce07c5183aee2c/MACS2-2.1.1.20160309.tar.gz
wget  ~~~~~~~~~~~~~~~~~~~~~~MACS2-2.1.1.20160309.tar.gz
tar zxvf MACS2-2.1.1.20160309.tar.gz
cd MACS2-2.1.1.20160309
python setup.py install --user 
## https://docs.python.org/2/install/

#################### The log for installing MACS2: 
Creating ~/.local/lib/python2.7/site-packages/site.py
Processing MACS2-2.1.1.20160309-py2.7-linux-x86_64.egg
Copying MACS2-2.1.1.20160309-py2.7-linux-x86_64.egg to ~/.local/lib/python2.7/site-packages
Adding MACS2 2.1.1.20160309 to easy-install.pth file
Installing macs2 script to ~/.local/bin
Finished processing dependencies for MACS2==2.1.1.20160309
############################################################  
~/.local/bin/macs2 --help

Example for regular peak calling:
 	macs2 callpeak -t ChIP.bam -c Control.bam -f BAM -g hs -n test -B -q 0.01
Example for broad peak calling:
 	macs2 callpeak -t ChIP.bam -c Control.bam --broad -g hs --broad-cutoff 0.1

	
## Download and install blat
cd ~/biosoft
mkdir blat &&  cd blat
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/gfClient   
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/gfServer   
cp blat ~/my-bin/bin 

## Download and install Ghostscript
cd ~/biosoft
mkdir Ghostscript &&  cd Ghostscript
wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs919/ghostscript-9.19-linux-x86_64.tgz
tar zxvf ghostscript-9.19-linux-x86_64.tgz
cd ghostscript-9.19-linux-x86_64/
cp gs-919-linux_x86_64  ~/my-bin/bin/gs

## Download and install weblogo
cd ~/biosoft
mkdir weblogo &&  cd weblogo
wget http://weblogo.berkeley.edu/release/weblogo.2.8.2.tar.gz
cp seqlogo ~/my-bin/bin/
# WebLogo requires a recent version of gs (ghostscript) 
# <http://www.cs.wisc.edu/~ghost/> to create PNG and PDF output, and 
# ImageMagic's convert <http://www.imagemagick.org/> to create GIFs.
# 
# ./seqlogo -F PDF -f globin.fasta > globin.pdf   
# ./seqlogo -F PNG -f globin.fasta > globin.png
# ./seqlogo -F GIF -f globin.fasta > globin.png
# 

## Download and install seqlogo
# http://bioconductor.org/packages/release/bioc/html/seqLogo.html

## Download and install homer (Hypergeometric Optimization of Motif	EnRichment)
## // http://homer.salk.edu/homer/
## // http://blog.qiubio.com:8080/archives/3024	
## The commands gs, seqlogo, blat, and samtools should now work from the command line
cd ~/biosoft
mkdir homer &&  cd homer
wget http://homer.salk.edu/homer/configureHomer.pl 
perl configureHomer.pl -install
perl configureHomer.pl -install hg19



## Download and install SWEMBL
cd ~/biosoft
mkdir SWEMBL &&  cd SWEMBL
#### readme: http://www.ebi.ac.uk/~swilder/SWEMBL/beginners.html
wget http://www.ebi.ac.uk/~swilder/SWEMBL/SWEMBL.3.3.1.tar.bz2 
tar xvfj SWEMBL.3.3.1.tar.bz2
cd SWEMBL.3.3.1/
make
## error 

## Download and install SISSRs
cd ~/biosoft
mkdir SISSRs &&  cd SISSRs
#### readme: https://dir.nhlbi.nih.gov/papers/lmi/epigenomes/sissrs/SISSRs-Manual.pdf
wget http://dir.nhlbi.nih.gov/papers/lmi/epigenomes/sissrs/sissrs_v1.4.tar.gz
tar xzvf sissrs_v1.4.tar.gz
~/biosoft/SISSRs/sissrs.pl

## Download and install fastqc
cd ~/biosoft
mkdir fastqc &&  cd fastqc
wget http://www.bioinformatics.bbsrc.ac.uk/projects/fastqc/fastqc_v0.11.5.zip

## Download and install CEAS    
## http://liulab.dfci.harvard.edu/CEAS/download.html

cd ~/biosoft
mkdir CEAS  &&  cd CEAS 
wget  http://liulab.dfci.harvard.edu/CEAS/src/CEAS-Package-1.0.2.tar.gz
tar zxvf CEAS-Package-1.0.2.tar.gz
cd  CEAS-Package-1.0.2
python setup.py install --user 
## http://liulab.dfci.harvard.edu/CEAS/usermanual.html
 ~/.local/bin/ceas --help  
mkdir annotation  &&  cd annotation  
wget http://liulab.dfci.harvard.edu/CEAS/src/hg19.refGene.gz ; gunzip hg19.refGene.gz 
# http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz ##  gunzip refGene.txt.gz ; mv refGene.txt  hg19refGene.txt
 
 








