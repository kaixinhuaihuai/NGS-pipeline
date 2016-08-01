## usage: Rscript  peakView.R  peaks.bed 
#options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ; 
library(ChIPpeakAnno)  
library(EnsDb.Hsapiens.v75) 
gr1 <- toGRanges(bedPeaksFile, format="BED")  
peaks=gr1 
annoData <- genes(EnsDb.Hsapiens.v75)
annoData[1:2]
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)
## do annotation by nearest TSS
## Obtain the distance to the nearest TSS, miRNA, exon et al for a list of peak
anno <- annotatePeakInBatch(peaks, AnnotationData=annoData)
anno[1:2]
# A pie chart can be used to demonstrate the overlap features of the peaks.
pie1(table(anno$insideFeature))
## ----addIDs--------------------------------------------------------------
library(org.Hs.eg.db)
anno <- addGeneIDs(anno, orgAnn="org.Hs.eg.db", 
                   feature_id_type="ensembl_gene_id",
                   IDs2Add=c("symbol"))
 
head(anno)
annoEnsDb=anno
annoEnsDb_df <- as.data.frame(annoEnsDb)
write.csv(annoEnsDb_df,'peaksAnnoEnsDb.csv',col.names = F)

a=anno$distancetoFeature
a=a[!is.na(a)]
a=a[abs(a)<5000]
t=hist(a,breaks=seq(-5000,5000, by = 50))
t$counts

