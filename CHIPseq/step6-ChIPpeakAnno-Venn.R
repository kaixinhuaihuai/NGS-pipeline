rm(list=ls())
require(ChIPseeker)
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
require(clusterProfiler) 
bedFiles=list.files(pattern = '*bed')

library(ChIPpeakAnno)
BAF180_CT10_peaks <- readPeakFile( bedFiles[1] )
BAF180_CT22_peaks <- readPeakFile( bedFiles[2] )
BAF180_CT22AM_peaks <- readPeakFile( bedFiles[3] )
SRC2mutREV_ERB_peaks <- readPeakFile( bedFiles[4] )
WT_REV_ERB_peaks <- readPeakFile( bedFiles[5] )

ol <- findOverlapsOfPeaks(BAF180_CT10_peaks, BAF180_CT22_peaks,BAF180_CT22AM_peaks,
                          SRC2mutREV_ERB_peaks,WT_REV_ERB_peaks)
png('overlapVenn.png')
makeVennDiagram(ol)
dev.off()

BAF180_ol <- findOverlapsOfPeaks(BAF180_CT10_peaks, BAF180_CT22_peaks,BAF180_CT22AM_peaks )
png('BAF180_overlapVenn.png')
makeVennDiagram(BAF180_ol)
dev.off()

SRC2_ol <- findOverlapsOfPeaks( SRC2mutREV_ERB_peaks,WT_REV_ERB_peaks)
png('SRC2_overlapVenn.png')
makeVennDiagram(SRC2_ol)
dev.off()