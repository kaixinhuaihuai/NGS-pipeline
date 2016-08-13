## usage: cuffdiff.sh
## just run this script according to tophat results:
## Firstly check the tophat results by :  ls  tophat_results/*/accept_hits.bam  
## 
~/biosoft/Cufflinks/current/cuffdiff  -p 20 \
-u ~/annotation/gencode/v24_GRCH37/gencode.v24lift37.annotation.gtf   \
-b ~/biosoft/bowtie/hg19_index/hg19.fa  \
-L Alb_Dex,untreated \
-o Alb_Dex-VS-untreated.diffout  \
N61311_Alb_Dex/accepted_hits.bam,  N052611_Alb_Dex/accepted_hits.bam,  N061011_Alb_Dex/accepted_hits.bam,  N080611_Alb_Dex/accepted_hits.bam  \
N61311_untreated/accepted_hits.bam,N052611_untreated/accepted_hits.bam,N061011_untreated/accepted_hits.bam,N080611_untreated/accepted_hits.bam  
