## bam to wig 
samtools depth SRR1042593.sorted.bam | perl -ne 'BEGIN{ print "track type=print wiggle_0 name=SRR1042593 description=SRR1042593\n"}; ($c, $start, $depth) = split; if ($c ne $lastC) { print "variableStep chrom=$c span=10\n"; };$lastC=$c; next unless $. % 10 ==0;print "$start\t$depth\n" unless $depth<3' > SRR1042593.wig
samtools depth SRR1042594.sorted.bam | perl -ne 'BEGIN{ print "track type=print wiggle_0 name=SRR1042594 description=SRR1042594\n"}; ($c, $start, $depth) = split; if ($c ne $lastC) { print "variableStep chrom=$c span=10\n"; };$lastC=$c; next unless $. % 10 ==0;print "$start\t$depth\n" unless $depth<3' > SRR1042594.wig

