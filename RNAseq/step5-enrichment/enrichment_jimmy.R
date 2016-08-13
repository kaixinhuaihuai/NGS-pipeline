hyperGtest_jimmy <- function(GeneID2Path,Path2GeneID,diff_gene,universeGeneIds){
  diff_gene_has_path=intersect(diff_gene,names(GeneID2Path))
  n=length(diff_gene) #306
  N=length(universeGeneIds) #5870
  results=c()
 
  for (i in names(Path2GeneID)){
    M=length(intersect(Path2GeneID[[i]],universeGeneIds)) 
    exp_count=n*M/N
	#print(paste(n,N,M,sep="\t"))
    k=0
    for (j in diff_gene_has_path){
      if (i %in% GeneID2Path[[j]]) k=k+1
    }
    OddsRatio=k/exp_count
    if (k==0) next
    p=phyper(k-1,M, N-M, n, lower.tail=F)
    #print(paste(i,p,OddsRatio,exp_count,k,M,sep="    "))
    results=rbind(results,c(i,p,OddsRatio,exp_count,k,M))
  }
  colnames(results)=c("PathwayID","Pvalue","OddsRatio","ExpCount","Count","Size")
  return(results)
}

dir_bin=getwd()

if(T){ ## read the update_kegg !!
	path2gene_file=file.path(dir_bin,'KEGG_update','kegg2geneID.txt')
	path2name_file=file.path(dir_bin,'KEGG_update','kegg_hierarchical.txt') 
	if (file.exists(path2gene_file)){
		tmp=read.table(path2gene_file,sep="\t",colClasses=c('character'))
		#tmp=toTable(org.Hs.egPATH)
		# first column is kegg ID, second column is entrez ID 
		GeneID2kegg<<- tapply(tmp[,1],as.factor(tmp[,2]),function(x) x)
		kegg2GeneID<<- tapply(tmp[,2],as.factor(tmp[,1]),function(x) x)
	}else{stop("we can not find the file:path2gene_file")}
	if (file.exists(path2name_file)){
		kegg2name<<- read.delim(path2name_file,header=F,sep="\t",colClasses=c('character'),stringsAsFactors =F)
		colnames(kegg2name)=c('parent1','parent2','pathway_id','pathway_name')
		###kegg2name$pathway_id=as.numeric(kegg2name$pathway_id)
		rownames(kegg2name)=kegg2name$pathway_id
	}else{stop("we can not find the file:path2name_file")}
}

args <- commandArgs(trailingOnly = TRUE)

diff_gene_file=ifelse(is.na(args[1]),'lincs_entrez_gene_list.txt',args[1]);
all_genes_file=ifelse(is.na(args[2]),file.path(dir_bin,'backgroudGenelist','hgu133plus2.genelist.txt'),args[2]); 
diff_gene_list = read.table(diff_gene_file)[,1]
all_genes_list = read.table(diff_gene_file)[,1]



annotationPKG='org.Hs.eg.db'
suppressMessages(library(GO.db))
suppressMessages(library(KEGG.db))
suppressMessages(library(GOstats))
suppressMessages(library(org.Hs.eg.db))


kegg_result=hyperGtest_jimmy(GeneID2kegg,kegg2GeneID,diff_gene_list,all_genes_list)
kegg_result=as.data.frame(kegg_result,stringsAsFactors = F)
kegg_result$pathway_name=kegg2name[match(kegg_result[,1],kegg2name[,'pathway_id']),'pathway_name']
kegg_result=kegg_result[order(as.numeric(kegg_result[,2])),]
kegg_result$PathwayID = paste0('hsa:', kegg_result$PathwayID )
write.csv(kegg_result,"update_kegg.enrichment.csv")
if(T){
  GOES = c('BP','CC', 'MF');
  for (ontology in GOES) {
    GO.hyperG.params = new("GOHyperGParams", geneIds=diff_gene_list, universeGeneIds=all_genes_list, annotation=annotationPKG, 
                           ontology=ontology, pvalueCutoff=1, conditional = FALSE, testDirection = "over")
    GO.hyperG.results = hyperGTest(GO.hyperG.params);
    outHTMLname=paste("GO_",ontology,".enrichment.html",sep="")
    #htmlReport(GO.hyperG.results, file=outHTMLname, summary.args=list("htmlLinks"=TRUE))
    GO.hyperG.matrix=summary(GO.hyperG.results)
    outMatrixName=paste("GO.",ontology,".hyperG.summary.csv",sep="")
    write.csv(GO.hyperG.matrix,outMatrixName)
  }	
  #options(digits=4);	
  hyperG.params = new("KEGGHyperGParams", geneIds=diff_gene_list, universeGeneIds=all_genes_list, annotation=annotationPKG, 
                      categoryName="KEGG", pvalueCutoff=1, testDirection = "over")
  KEGG.hyperG.results = hyperGTest(hyperG.params); 
  outHTMLname="kegg.enrichment.html"
  #htmlReport(KEGG.hyperG.results, file=outHTMLname, summary.args=list("htmlLinks"=TRUE))
  KEGG.hyperG.matrix=summary(KEGG.hyperG.results)
  outMatrixName="kegg.hyperG.summary.csv"
  KEGG.hyperG.matrix$KEGGID=paste0('hsa:',KEGG.hyperG.matrix$KEGGID)
  write.csv(KEGG.hyperG.matrix,outMatrixName)
}


