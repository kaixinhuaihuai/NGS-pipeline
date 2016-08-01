## usage: Rscript  peakView.R  peaks.bed 
#options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
if(length(args) != 1 ){
	print(" usage: Rscript  peakAnno.R  peaks.bed ")
}

bedPeaksFile 		= args[1] ; 

## loading packages
require(ChIPseeker)
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
require(clusterProfiler) 

peak <- readPeakFile( bedPeaksFile ) 
keepChr= !grepl('_',seqlevels(peak))
seqlevels(peak, force=TRUE) <- seqlevels(peak)[keepChr]
covplot(peak, weightCol="V5")
#covplot(peak, weightCol="V5", chrs=c("chr17", "chr18"), xlim=c(4.5e7, 5e7))

promoter <- getPromoters(TxDb=txdb, upstream=3000, downstream=3000)
tagMatrix <- getTagMatrix(peak, windows=promoter)
## ----fig.cap="Heatmap of ChIP peaks binding to TSS regions", fig.align="center", fig.height=12, fig.width=4----
tagHeatmap(tagMatrix, xlim=c(-3000, 3000), color="red")
## a one step function to generate this figure from bed file.
#peakHeatmap(bedPeaksFile, TxDb=txdb, upstream=3000, downstream=3000, color="red")

## Then Average Profile of ChIP peaks binding to TSS region
plotAvgProf(tagMatrix, xlim=c(-3000, 3000), 
            xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")

## a one step from bed file to average profile plot.
plotAvgProf2(bedPeaksFile, TxDb=txdb, upstream=3000, downstream=3000, 
             xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")
plotAvgProf(tagMatrix, xlim=c(-3000, 3000), conf = 0.95, resample = 500)


peakAnno <- annotatePeak(bedPeaksFile, tssRegion=c(-3000, 3000), 
                         TxDb=txdb, annoDb="org.Hs.eg.db")
## Peak Annotation is performed by annotatePeak. User can define TSS (transcription start site) region, by default TSS is defined from -3kb to +3kb. 
## The output of annotatePeak is csAnno instance. 
## ChIPseeker provides as.GRanges to convert csAnno to GRanges instance, and as.data.frame to convert csAnno to data.frame which can be exported to file by write.table.

peakAnno_df <- as.data.frame(peakAnno)
plotAnnoPie(peakAnno)
plotAnnoBar(peakAnno)
vennpie(peakAnno)
#Since some annotation may overlap, ChIPseeker adopted the following priority in genomic annotation.
# Promoter
# 5’ UTR
# 3’ UTR
# Exon
# Intron
# Downstream
# Intergenic




 


