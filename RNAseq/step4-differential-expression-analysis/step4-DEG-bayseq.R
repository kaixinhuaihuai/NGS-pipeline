suppressPackageStartupMessages(library(DESeq))
suppressPackageStartupMessages(library(limma))
suppressPackageStartupMessages(library(DESeq2))
suppressPackageStartupMessages(library(edgeR))
suppressPackageStartupMessages(library(baySeq))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(pasilla))
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(CLL))


DEG_baySeq<- function(exprSet=exprSet,group_list=group_list){
	suppressMessages(library(baySeq))
	suppressMessages(library(snow))
	cl <- makeCluster(4, "SOCK")
	groups=list(NDE = rep(1,length(group_list)),
				DE = as.numeric(factor(group_list)) 
	)
	CD <- new("countData", data = exprSet, replicates = group_list, groups = groups )
	libsizes(CD) <- getLibsizes(CD)
	png("MA.png")
	 plotMA.CD(CD, samplesA = unique(group_list)[1], samplesB = unique(group_list)[2],
           col = c(rep("red", 100), rep("black", 900)))
	dev.off()
	CD <- getPriors.NB(CD, samplesize = 1000, estimation = "QL",cl=cl)
	CD <- getLikelihoods.NB(CD, pET = 'BIC', cl = cl)
	res=topCounts(CD, group = "DE")
	res=topCounts(CD, group = "DE",number = nrow(exprSet)) 
	png("Posteriors_distribution.png")
	plotPosteriors(CD, group = "DE", col = c(rep("red", 100), rep("black", 900)))
	dev.off()
	#write.csv(resOrdered,"deseq.results.csv",quote = F)
}



data(pasillaGenes)
exprSet=counts(pasillaGenes)
samples=sampleNames(pasillaGenes)
pdata=pData(pasillaGenes)[,c("condition","type")]
group_list=as.character(pdata[,1])
DEG_results=DEG_baySeq(exprSet,group_list)


