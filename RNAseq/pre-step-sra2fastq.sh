#ls *sra |while read id; do ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3 $id;done
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_untreated	SRR1039508.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Dex		SRR1039509.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Alb		SRR1039510.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N61311_Alb_Dex		SRR1039511.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_untreated		SRR1039512.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Dex		SRR1039513.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Alb		SRR1039514.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N052611_Alb_Dex		SRR1039515.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_untreated		SRR1039516.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Dex		SRR1039517.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Alb		SRR1039518.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N080611_Alb_Dex		SRR1039519.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_untreated		SRR1039520.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Dex		SRR1039521.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Alb		SRR1039522.sra &
nohup ~/biosoft/sratoolkit/sratoolkit.2.6.3-centos_linux64/bin/fastq-dump --split-3  --gzip -A  	N061011_Alb_Dex		SRR1039523.sra &
