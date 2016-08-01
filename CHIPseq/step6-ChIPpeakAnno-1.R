## usage: Rscript  peakView.R  peaks.bed  IP.sorted.bam  input.sorted.bam  10
#options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ;
## TSS.human.GRCh37
## TxDb.Hsapiens.UCSC.hg19.knownGene
## EnsDb.Hsapiens.v75 
## ----import--------------------------------------------------------------
#bedPeaksFile 		= 'Hek-Ip_peaks.bed'; 

library(ChIPpeakAnno) 
library(TxDb.Hsapiens.UCSC.hg19.knownGene)  
library(EnsDb.Hsapiens.v75)
data(TSS.human.GRCh37)
gr1 <- toGRanges(bedPeaksFile, format="BED")  

## ----summarize------------------------------------------------------------
## also need mirbase.db and FDb.UCSC.tRNAs packages
## it will annotate each peak region with genomic features in batch
##  summarize the distribution of peaks over different type of features such as exon, intron, enhancer, proximal promoter, 5’ UTR and 3’ UTR.
aCR<-assignChromosomeRegion(gr1, nucleotideLevel=FALSE, 
                            precedence=c("Promoters", "immediateDownstream", 
                                         "fiveUTRs", "threeUTRs", 
                                         "Exons", "Introns"), 
                            TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)
barplot(aCR$percentage, las=3)
# Please note that one peak might span multiple type of features, leading to the number of annotated features greater than the total number of input peaks.			   

## ----annotate by EnsDb.Hsapiens.v75------------------------------------- 
## keep the seqnames in the same style
peaks=gr1
library(EnsDb.Hsapiens.v75)
annoData <- genes(EnsDb.Hsapiens.v75)
annoData[1:2]
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)
## do annotation by nearest TSS
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

## ----annotate by TxDb.Hsapiens.UCSC.hg19.knownGene---------------------- 
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData[1:2]
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)

## ------------------------------------------------------------------------
anno <- annotatePeakInBatch(peaks, AnnotationData=annoData, 
                            output="overlapping", 
                            FeatureLocForDistance="TSS",
                            bindingRegion=c(-2000, 300))
anno$symbol <- xget(anno$feature, org.Hs.egSYMBOL)
head(anno)
 

data(TSS.human.GRCh37)
binOverFeature(gr1, annotationData=TSS.human.GRCh37,
               radius=5000, nbins=20, #FUN=length, errFun=0,
               ylab="count", 
               main="Distribution of aggregated peak numbers around TSS")



