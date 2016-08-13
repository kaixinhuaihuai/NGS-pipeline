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
# bedFiles=list.files(pattern = '*bed')
wd=getwd()
# > bedFiles
# [1] "BAF180_CT10_peaks.bed"    "BAF180_CT22_peaks.bed"   
# [3] "BAF180_CT22AM_peaks.bed"  "SRC2mutREV-ERB_peaks.bed"
# [5] "WT_REV-ERB_peaks.bed"  
# bedPeaksFile=bedFiles[5];setwd(wd) 

sampleName=strsplit(bedPeaksFile,'\\.')[[1]][1]
print(sampleName)
dir.create(file.path(wd,sampleName)) 
setwd(file.path(wd,sampleName))

bedPeaksFile = file.path(wd,bedPeaksFile)
if (!file.exists(bedPeaksFile)){
  stop(paste0("the file:",bedPeaksFile ,"did not exists!\n"))
}
## loading packages
require(ChIPseeker)
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
require(clusterProfiler) 
peak <- readPeakFile( bedPeaksFile ) 

#highPeak <- readPeakFile( 'highQuaily_peaks.bed' ) 
#uniquePeak <- readPeakFile( 'unique_peaks.bed' )  
#peak <-  uniquePeak
keepChr= !grepl('_',seqlevels(peak))
seqlevels(peak, force=TRUE) <- seqlevels(peak)[keepChr]
png('ChIP Peaks over Chromosomes.png')
covplot(peak, weightCol="V5")
dev.off()
#covplot(peak, weightCol="V5", chrs=c("chr17", "chr18"), xlim=c(4.5e7, 5e7))

promoter <- getPromoters(TxDb=txdb, upstream=3000, downstream=3000)
tagMatrix <- getTagMatrix(peak, windows=promoter)
## ----fig.cap="Heatmap of ChIP peaks binding to TSS regions", fig.align="center", fig.height=12, fig.width=4----
#tagHeatmap(tagMatrix, xlim=c(-3000, 3000), color="red")
png('tagHeatmap.png')
tagHeatmap(tagMatrix, xlim=c(-3000, 3000), color="red")
dev.off()
## a one step function to generate this figure from bed file.
#peakHeatmap(bedPeaksFile, TxDb=txdb, upstream=3000, downstream=3000, color="red")

## Then Average Profile of ChIP peaks binding to TSS region
png('Average Profile of ChIP peaks binding to TSS region.png')
plotAvgProf(tagMatrix, xlim=c(-3000, 3000), 
            xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")
dev.off()


# ## a one step from bed file to average profile plot.
# plotAvgProf2(bedPeaksFile, TxDb=txdb, upstream=3000, downstream=3000, 
#              xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")
# plotAvgProf(tagMatrix, xlim=c(-3000, 3000), conf = 0.95, resample = 500)


peakAnno <- annotatePeak(peak, tssRegion=c(-3000, 3000), 
                         TxDb=txdb, annoDb="org.Hs.eg.db")
## Peak Annotation is performed by annotatePeak. User can define TSS (transcription start site) region, by default TSS is defined from -3kb to +3kb. 
## The output of annotatePeak is csAnno instance. 
## ChIPseeker provides as.GRanges to convert csAnno to GRanges instance, and as.data.frame to convert csAnno to data.frame which can be exported to file by write.table.

peakAnno_df <- as.data.frame(peakAnno)
write.csv(peakAnno_df,'peakAnno_df.csv')
png('Pie-summarize the distribution of peaks over different type of features.png')
plotAnnoPie(peakAnno)
dev.off()
png('Bar-summarize the distribution of peaks over different type of features.png')
plotAnnoBar(peakAnno)
dev.off()

png('vennpie-summarize the distribution of peaks over different type of features.png')
vennpie(peakAnno)
dev.off()

peaksLength=abs(peakAnno_df$end-peakAnno_df$start)
peaksLength=peaksLength[peaksLength<10000] 
png(file="peakHist.png")
hist(peaksLength, breaks = 50, col = "lightblue", xlim=c(0,10000),xlab="peak length", main="Histogram of peak length")
dev.off()



# 
# Dtss=peakAnno_df$distanceToTSS
# Dtss=Dtss[Dtss>0]
# Dtss=Dtss[abs(Dtss) <3000]
# t=hist(Dtss,breaks=seq(-3000,3000, by = 50))
# t$counts
 
#Since some annotation may overlap, ChIPseeker adopted the following priority in genomic annotation.
# Promoter
# 5’ UTR
# 3’ UTR
# Exon
# Intron
# Downstream
# Intergenic




 


