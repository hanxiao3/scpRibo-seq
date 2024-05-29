#!/usr/perl/bin
open(IN,"Random_sampling.list");
$n=0;
system ("mkdir shell.heatmap");
chomp(@fqs=<IN>);
foreach $fq (@fqs) {
$n++;
$name="group_".$n;
$fq =~/(\S+)\t(\S+)/;

open(OUT,">./shell.heatmap/$1.R");

print OUT "setwd(\"/$name\")
a=read.table(\"./randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM\",header=T,row.names = 1)
library(pheatmap)
pdf(\"randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.pdf\",width =5,height =7 )
pheatmap(a,cluster_rows=T,scale = \"row\",
         cluster_cols=F,show_rownames=T,
         color = colorRampPalette(c( \"navy\", \"white\", \"gold\"))(300))
dev.off()	
pdf(\"randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.pdf\",width =5,height =6 )
x=cor(a)
pheatmap(x,cluster_rows=T,display_numbers=TRUE,number_format=\"%.2f\",fontsize=10,
         cluster_cols=T,show_rownames=T,
         color = colorRampPalette(c( \"navy\", \"white\", \"gold\"))(300))
write.table(x,file=\"randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.txt\",append=T,row.names=F,col.names=F)
dev.off()	

library(ape)
df = x
df.cluster = hclust(dist(df))
df.cluster2=cutree(df.cluster, k = 2)
write.table(df.cluster2,file=\"randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.tree.txt\",append=T,row.names=T,col.names=T)

###PCA
a=read.table(\"./randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM\",header=T,row.names = 1)
pdf(\"randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.PCA.pdf\",width =6,height =5.5 )

group_list=read.table(\"../group_list\",head=F)
dim(dat)
dat=t(dat)
dat=as.data.frame(dat)
dat=cbind(dat,group_list)
library(\"FactoMineR\")
library(\"factoextra\") 
ncol(dat)
dat[,ncol(dat)]
dat.pca <- PCA(dat[,-ncol(dat)], graph = FALSE)
fviz_pca_ind(dat.pca,
             mean.point=F,
             geom.ind = c(\"point\", \"text\"),
             pointshape = 16,
             col.ind = dat\$V1, 
             addEllipses = T,
             legend.title = \"Groups\",
             ellipse.type=\"confidence\", ellipse.level=0.95)
dev.off()	


		 


";


}
