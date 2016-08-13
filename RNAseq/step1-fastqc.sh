ls *.fastq  *fq * fq.gz | while read id ; do ~/biosoft/fastqc/FastQC/fastqc $id;done 
mkdir QC_results 
mv *zip *html QC_results 