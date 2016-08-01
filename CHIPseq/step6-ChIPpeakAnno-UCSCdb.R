## usage: Rscript  peakView.R  peaks.bed 
#options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ; 
library(ChIPpeakAnno)  
library(TxDb.Hsapiens.UCSC.hg19.knownGene) 
gr1 <- toGRanges(bedPeaksFile, format="BED")  
peaks=gr1  
## ------------------------------------------------------------------------ 
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData[1:2]
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)
## do annotation by nearest TSS
## output	 nearestLocation (default): 
## FeatureLocForDistance	TSS means using start of feature when feature is on plus strand and using end of feature when feature is on minus strand
anno <- annotatePeakInBatch(peaks, AnnotationData=annoData  ) 
pie1(table(anno$insideFeature))
## ----addIDs--------------------------------------------------------------
library(org.Hs.eg.db)
anno <- addGeneIDs(anno, orgAnn="org.Hs.eg.db", 
                   feature_id_type="entrez_id",
                   IDs2Add=c("symbol"))
head(anno)
annoUCSC=anno
annoUCSC_df <- as.data.frame(annoUCSC)
write.csv(annoUCSC_df,'peaksAnnoUCSC.csv')
 


