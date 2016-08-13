## Download and install CEAS    
## http://liulab.dfci.harvard.edu/CEAS/download.html
cd ~/biosoft
mkdir CEAS  &&  cd CEAS 
wget  http://liulab.dfci.harvard.edu/CEAS/src/CEAS-Package-1.0.2.tar.gz
tar zxvf CEAS-Package-1.0.2.tar.gz
cd  CEAS-Package-1.0.2
python setup.py install --user 
## http://liulab.dfci.harvard.edu/CEAS/usermanual.html
 ~/.local/bin/ceas --help  

mkdir annotation  &&  cd annotation  
wget http://liulab.dfci.harvard.edu/CEAS/src/hg19.refGene.gz ; gunzip hg19.refGene.gz 

~/.local/bin/ceas --name=H3K36me3_ceas --pf-res=20 --gn-group-names='Top 10%,Bottom 10%'  \
-g -g  ~/biosoft/CEAS/annotation/hg19.refGene  -b  ../paper_results/GSM1278641_Xu_MUT_rep1_BAF155_MUT.peaks.bed -w ../rawData/SRR1042593.wig 




