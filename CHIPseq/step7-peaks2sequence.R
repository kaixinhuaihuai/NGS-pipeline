## usage: Rscript  peakView.R  peaks.bed  IP.sorted.bam  input.sorted.bam  10
#options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ;
#bedPeaksFile 		= 'Hek-Ip_peaks.bed'; 
gr1 <- toGRanges(bedPeaksFile, format="BED") 
library(BSgenome.Hsapiens.UCSC.hg19)
seq <- getAllPeakSequence(gr1, upstream=20, downstream=20, genome=Hsapiens)
write2FASTA(seq, "test.fa")