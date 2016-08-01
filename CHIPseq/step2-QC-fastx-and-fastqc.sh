## step4 : run FastQC to check the sequencing quality.

ls *.fastq | while read id ; do ~/biosoft/fastqc/FastQC/fastqc $id;done
## Sequence length 51 
## %GC 39 
## Adapter Content passed 
 
## Then you need to open the html style files and check the quality for each data.
## we don't need to do any filter or trim if The quality of the reads is pretty good

## Then we need to filter the bad quality reads according to the QC results.
## write a script by cat >filter.sh 
ls *fastq |while read id 
do
echo $id 
## you need to adjust the parameter by yourself according to the QC results.
~/biosoft/fastx_toolkit_0.0.13/bin/fastq_quality_filter -v -q 20 -p 80 -Q33  -i $id -o tmp ;
~/biosoft/fastx_toolkit_0.0.13/bin/fastx_trimmer -v -f 1 -l 27 -i tmp  -Q33 -z -o ${id%%.*}_clean.fq.gz ;
done 
rm tmp 

## discarded 12%~~49%%
ls *_clean.fq.gz | while read id ; do ~/biosoft/fastqc/FastQC/fastqc $id;done

mkdir QC_results
mv *zip *html QC_results/

