## usage: Rscript  peakView.R  peaks.bed 
#options(echo=TRUE) # if you want see commands in output file
##  exon, intron, enhancer, proximal promoter, 5’ UTR and 3’ UTR
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ; 
library(ChIPpeakAnno)  
library(TxDb.Hsapiens.UCSC.hg19.knownGene) 
gr1 <- toGRanges(bedPeaksFile, format="BED")  

## ----summarize------------------------------------------------------------
## also need mirbase.db and FDb.UCSC.tRNAs packages
## it will annotate each peak region with genomic features in batch
##  summarize the distribution of peaks over different type of features such as
aCR<-assignChromosomeRegion(gr1, nucleotideLevel=FALSE, 
                            precedence=c("Promoters", "immediateDownstream", 
                                         "fiveUTRs", "threeUTRs", 
                                         "Exons", "Introns"), 
                            TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)
barplot(aCR$percentage, las=3)

