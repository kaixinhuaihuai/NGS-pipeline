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
