suppressPackageStartupMessages(library(DESeq))
suppressPackageStartupMessages(library(limma))
suppressPackageStartupMessages(library(DESeq2))
suppressPackageStartupMessages(library(edgeR))
suppressPackageStartupMessages(library(baySeq))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(CLL))

DEG_DESeq2 <- function(exprSet=exprSet,group_list=group_list){
	suppressMessages(library(DESeq2))
	exprSet=ceiling(exprSet)
	(colData <- data.frame(row.names=colnames(exprSet), group_list=group_list))
	dds <- DESeqDataSetFromMatrix(countData = exprSet,
								colData = colData,
								design = ~ group_list)
	dds <- DESeq(dds)
	png("qc_dispersions.png", 1000, 1000, pointsize=20)
	plotDispEsts(dds, main="Dispersion plot")
	dev.off()
	res <- results(dds)
	
	png("RAWvsNORM.png")
	rld <- rlogTransformation(dds)
	exprSet_new=assay(rld)
	par(cex = 0.7)
	n.sample=ncol(exprSet)
	if(n.sample>40) par(cex = 0.5)
	cols <- rainbow(n.sample*1.2)
	par(mfrow=c(2,2))
	boxplot(exprSet, col = cols,main="expression value",las=2)
	boxplot(exprSet_new, col = cols,main="expression value",las=2)
	hist(exprSet)
	hist(exprSet_new)
	dev.off()
	
	library(RColorBrewer)
	(mycols <- brewer.pal(8, "Dark2")[1:length(unique(group_list))])

	# Sample distance heatmap
	sampleDists <- as.matrix(dist(t(exprSet_new)))
	#install.packages("gplots",repos = "http://cran.us.r-project.org")
	library(gplots)
	png("qc-heatmap-samples.png", w=1000, h=1000, pointsize=20)
	heatmap.2(as.matrix(sampleDists), key=F, trace="none",
			  col=colorpanel(100, "black", "white"),
			  ColSideColors=mycols[group_list], RowSideColors=mycols[group_list],
			  margin=c(10, 10), main="Sample Distance Matrix")
	dev.off()

	png("MA.png")
	DESeq2::plotMA(res, main="DESeq2", ylim=c(-2,2))
	dev.off()
	resOrdered <- res[order(res$padj),]
	resOrdered=as.data.frame(resOrdered)
	#write.csv(resOrdered,"deseq2.results.csv",quote = F)
}

DEG_DESeq <- function(exprSet=exprSet,group_list=group_list){
	suppressMessages(library(DESeq))
	exprSet=ceiling(exprSet)
	de=newCountDataSet(exprSet,group_list)
	de=estimateSizeFactors(de)
	de=estimateDispersions(de)
	png("qc_dispersions.png", 1000, 1000, pointsize=20)
	DESeq::plotDispEsts(de, main="Dispersion plot")
	dev.off()
	
	res=nbinomTest(de,unique(group_list)[1],unique(group_list)[2])
	png("MA.png")
	DESeq::plotMA(res)
	dev.off()
	rownames(res)=res[,1]
	res=res[,-1]
	resOrdered <- res[order(res$padj),]
	#write.csv(resOrdered,"deseq.results.csv",quote = F)
}


data(pasillaGenes)
exprSet=counts(pasillaGenes)
samples=sampleNames(pasillaGenes)
pdata=pData(pasillaGenes)[,c("condition","type")]
group_list=as.character(pdata[,1])
DEG_results=DEG_DESeq(exprSet,group_list)
DEG_results=DEG_DESeq2(exprSet,group_list)

