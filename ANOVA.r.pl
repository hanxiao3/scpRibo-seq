#!/usr/perl/bin
open(IN,"Random_sampling.list");
$n=0;
system ("mkdir shell.ANOVA");
chomp(@fqs=<IN>);
foreach $fq (@fqs) {
$n++;
$name="group_".$n;
$fq =~/(\S+)\t(\S+)/;

open(OUT,">./shell.ANOVA/$1.R");

print OUT "setwd(\"/$name\")
a=read.table(\"ANOVA.input\",header=T,sep=\"\\t\")
Pvalue<-c(rep(0,nrow(a)))
log2_FC<-c(rep(0,nrow(a)))
type<-factor(c(rep(\"c\",5),rep(\"m\",5)))
for(i in 1:nrow(a)){
  
  if(sum(a[i,2:6])==0 && sum(a[i,7:11])==0){
    
    Pvalue[i] <- \"NA\"
    
    log2_FC[i]<- \"NA\"
    
  }
  else{
    
    y=aov(as.numeric(a[i,2:11])~type)
    
    Pvalue[i]<-summary(y)[[1]][,5][1]
    
    log2_FC[i]<-log2((mean(as.numeric(a[i,2:6]))+0.001)/(mean(as.numeric(a[i,7:11]))+0.001))
    
  }
  
}

fdr=p.adjust(Pvalue, \"BH\")
out<-cbind(a,log2_FC,Pvalue,fdr)
write.table(out,file=\"ANOVA.out\",quote=FALSE,sep=\"\\t\",row.names=FALSE)
";


}
