#!/usr/perl/bin
open(IN,"Random_sampling.list");
$n=0;
system ("mkdir shell.wilcox");
chomp(@fqs=<IN>);
foreach $fq (@fqs) {
$n++;
$name="group_".$n;
$fq =~/(\S+)\t(\S+)/;

open(OUT,">./shell.wilcox/$1.R");

print OUT "setwd(\"/$name\")
a1 <-read.table(\"a1\",header=T,row.names=NULL)
a2 <-read.table(\"a2\",header=T,row.names=NULL)
list<-read.table(\"a3\")

for(i in 1:nrow(list)){
  z<-a1[which(a1[,1]==as.character(list[i,])),]
  y<-a2[which(a2[,1]==as.character(list[i,])),]
  z = t(z)
  z=z[-1,]
  z = t(z)
  y = t(y)
  y=y[-1,]
  y = t(y)
  p<-wilcox.test(as.numeric(z[1,]),as.numeric(y[1,]))\$p.value
  out<-paste(list[i,],p)
  write.table(out,file=\"wilcox.test.pvalue\",append=T,row.names=F,col.names=F,sep=\"\t\")
}
";


}
