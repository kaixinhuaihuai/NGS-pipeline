broadPeak=read.table("E001-H3K4me1.broadPeak",stringsAsFactors=F)
gappedPeak=read.table("E001-H3K4me1.gappedPeak",stringsAsFactors=F)
narrowPeak=read.table("E001-H3K4me1.narrowPeak",stringsAsFactors=F)
inputBed =read.table("E001-Input.tagAlign",stringsAsFactors=F)
chipBed  =read.table("E001-H3K4me1.tagAlign",stringsAsFactors=F)
colnames(inputBed)=c("chrom" , "start" , "end"   , "name"  , "score" , "strand")
colnames(chipBed) =c("chrom" , "start" , "end"   , "name"  , "score" , "strand")
inputBed$strand   =ifelse(inputBed$strand=='+',1,-1)
chipBed$strand    =ifelse(chipBed$strand=='+',1,-1)

library('Sushi')

PeakView <- function(peaks,name,num){
	if( !is.na(num) ){
		peaks=peaks[1:num,]
	}
	apply(peaks,1,function(x){
		chrom            = trimws(x[1])
		chromstart       = as.numeric(x[2])
		chromend         = as.numeric(x[3])
		png( paste0(trimws(x[4]),'_',name,'.png') )

		plotBed(beddata    = chipBed,chrom = chrom,chromstart = chromstart,
				chromend =chromend,colorby    = chipBed$strand,
				colorbycol = SushiColors(2),row  = "auto",wiggle=0.001,splitstrand=TRUE)

		labelgenome(chrom,chromstart,chromend,n=2,scale="Kb")

		legend("topright",inset=0,legend=c("reverse","forward"),fill=SushiColors(2)(2),
			   border=SushiColors(2)(2),text.font=2,cex=0.75)
		dev.off()
	})
}
PeakView(broadPeak ,'broadPeak' ,50 )
PeakView(gappedPeak,'gappedPeak',50 )
PeakView(narrowPeak,'narrowPeak',50 )


# > fivenum(broadPeak[,2]-broadPeak[,3])
# [1] -165910.0   -2034.0   -1030.5    -535.0    -194.0
# > fivenum(broadPeak[,3]-broadPeak[,2])
# [1]    194.0    535.0   1030.5   2034.0 165910.0
# > fivenum(gappedPeak[,3]-gappedPeak[,2])
# [1]    200   1219   2079   3479 165910
# > fivenum(narrowPeak[,3]-narrowPeak[,2])
# [1]  194  236  332  530 7401
# >