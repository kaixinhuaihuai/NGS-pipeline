## step1 : download raw data from SRA database
cd ~ 
mkdir CHIPseq_test && cd CHIPseq_test
mkdir rawData && cd rawData
## batch download the raw data by shell script :

for ((i=593;i<601;i++)) ;do wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP033/SRP033492/SRR1042$i/SRR1042$i.sra;done

## step2 :  change sra data to fastq files.
## cell line: MCF7 //  Illumina HiSeq 2000 //  50bp // Single ends // phred+33
## http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE52964
## ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP033/SRP033492 

ls *sra |while read id; do ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump $id;done
rm *sra

## information for these data ! 

# 621M Jun 27 14:03 SRR1042593.sra (16.9M reads)
# 2.2G Jun 27 15:58 SRR1042594.sra (60.6M reads)
# 541M Jun 27 16:26 SRR1042595.sra (14.6M reads)
# 2.4G Jun 27 18:24 SRR1042596.sra (65.9M reads)
# 814M Jun 27 18:59 SRR1042597.sra (22.2M reads)
# 2.1G Jun 27 20:30 SRR1042598.sra (58.1M reads)
# 883M Jun 27 21:08 SRR1042599.sra (24.0M reads)
# 2.8G Jun 28 11:53 SRR1042600.sra (76.4M reads)

##  621M --> 3.9G 
##  2.2G --> 14G
##  541M --> 3.3G
##  2.4G --> 15G
