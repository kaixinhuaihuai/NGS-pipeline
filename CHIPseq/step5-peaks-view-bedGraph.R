broadPeak		=read.table("E001-H3K4me1.broadPeak",stringsAsFactors=F)
gappedPeak		=read.table("E001-H3K4me1.gappedPeak",stringsAsFactors=F)
narrowPeak		=read.table("E001-H3K4me1.narrowPeak",stringsAsFactors=F)
inputBedGraph	=read.table("E001-Input.bedGraph",stringsAsFactors=F)
chipBedGraph	=read.table("E001-H3K4me1.bedGraph",stringsAsFactors=F)

library('Sushi')

PeakView <- function(peaks,name,num){
	if( !is.na(num) ){
		peaks=peaks[1:num,]
	}
	apply(peaks,1,function(x){
		chrom            = trimws(x[1])
		chromstart       = as.numeric(x[2])
		chromend         = as.numeric(x[3])
		png( paste0(trimws(x[4]),'_',name,'peak.png') )
		## SushiColors(2)(2)  blue and red !!! 
		plotBedgraph(inputBedGraph,chrom,chromstart,chromend,
					transparency=.50,color=SushiColors(2)(2)[1])
		plotBedgraph(chipBedGraph,chrom,chromstart,chromend,
					transparency=.50,color=SushiColors(2)(2)[2],overlay=TRUE,
					rescaleoverlay=TRUE)
		labelgenome(chrom,chromstart,chromend,n=3,scale="Kb")
		legend("topright",inset=0.025,legend=c("IP","INPUT"),
				fill=opaque(SushiColors(2)(2)),border=SushiColors(2)(2),text.font=2,
				cex=1.0)

		dev.off()
	})
}
PeakView(broadPeak ,'broadPeak' ,5 )
PeakView(gappedPeak,'gappedPeak',5 )
PeakView(narrowPeak,'narrowPeak',5 )
