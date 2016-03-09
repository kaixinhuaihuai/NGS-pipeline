#10.Merge individual BAM files
samtools merge sampe.merged.bam  *.realgn.bam
samtools index sampe.merged.bam
