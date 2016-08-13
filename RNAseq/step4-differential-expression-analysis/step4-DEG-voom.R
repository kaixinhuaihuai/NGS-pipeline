suppressPackageStartupMessages(library(DESeq))
suppressPackageStartupMessages(library(limma))
suppressPackageStartupMessages(library(DESeq2))
suppressPackageStartupMessages(library(edgeR))
suppressPackageStartupMessages(library(baySeq))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(CLL))


DEG_voom <- function(exprSet=exprSet,group_list=group_list){
	suppressMessages(library(limma))
	design <- model.matrix(~0+factor(group_list))
	colnames(design)=levels(factor(group_list))
	rownames(design)=colnames(exprSet)
	v <- voom(exprSet,design,normalize="quantile")
	png("RAWvsNORM.png")
	exprSet_new=v$E
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
	

	png("MDS.png")
	plotMDS(v, labels=1:ncol(exprSet),col=rainbow(ncol(exprSet)))
	legend("topright", legend=unique(group_list), col=1:2, pch=15)
	dev.off()
	fit <- lmFit(v,design)
	png("MA.png")
	limma::plotMA(fit)
	#abline(0,0,col="blue")
	dev.off()

	fit2 <- eBayes(fit)
	tempOutput = topTable(fit2, coef=1, n=Inf)
	nrDEG2 = na.omit(tempOutput)
	#write.csv(nrDEG2,"voom.results.csv",quote = F)
}



data(pasillaGenes)
exprSet=counts(pasillaGenes)
samples=sampleNames(pasillaGenes)
pdata=pData(pasillaGenes)[,c("condition","type")]
group_list=as.character(pdata[,1])
DEG_results=DEG_voom(exprSet,group_list)


