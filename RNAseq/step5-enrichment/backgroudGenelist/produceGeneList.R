library(org.Hs.eg.db)
library(hgu133plus2.db)
library(hgu133a.db)
library(hgu95av2.db) 
write.table(unique(toTable(hgu95av2ENTREZID)[,2]),'hgu95av2.genelist.txt'
            ,row.names = F,col.names = F ,quote = F)
write.table(unique(toTable(hgu133aENTREZID)[,2]),'hgu133a.genelist.txt'
            ,row.names = F,col.names = F ,quote = F)
write.table(unique(toTable(hgu133plus2ENTREZID)[,2]),'hgu133plus2.genelist.txt'
            ,row.names = F,col.names = F ,quote = F)
write.table(unique(toTable(org.Hs.egSYMBOL)[,1]),'org.Hs.eg.genelist.txt'
            ,row.names = F,col.names = F ,quote = F)