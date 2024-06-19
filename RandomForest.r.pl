#!/usr/perl/bin
open(IN,"Random_sampling.list");
$n=0;
system ("mkdir shell.randomForest");
chomp(@fqs=<IN>);
foreach $fq (@fqs) {
$n++;
$name="group_".$n;
$fq =~/(\S+)\t(\S+)/;

open(OUT,">./shell.randomForest/$1.R");

print OUT "setwd(\"/$name/randomForest\")
library(randomForest)

##1
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
pdf(\"ANOVA.p0.05.randomForest1.input.pdf\",width =8,height =10 )
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest1.input.importance.xls\")
dev.off()


###2
pdf(\"ANOVA.p0.05.randomForest2.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest2.input.importance.xls\")
dev.off()

###3
pdf(\"ANOVA.p0.05.randomForest3.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest3.input.importance.xls\")
dev.off()


###4
pdf(\"ANOVA.p0.05.randomForest4.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest4.input.importance.xls\")
dev.off()


###5
pdf(\"ANOVA.p0.05.randomForest5.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest5.input.importance.xls\")
dev.off()


###6
pdf(\"ANOVA.p0.05.randomForest6.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest6.input.importance.xls\")
dev.off()

###7
pdf(\"ANOVA.p0.05.randomForest7.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest7.input.importance.xls\")
dev.off()

###8
pdf(\"ANOVA.p0.05.randomForest8.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest8.input.importance.xls\")
dev.off()

###9
pdf(\"ANOVA.p0.05.randomForest9.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest9.input.importance.xls\")
dev.off()

###10
pdf(\"ANOVA.p0.05.randomForest10.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest10.input.importance.xls\")
dev.off()

###11
pdf(\"ANOVA.p0.05.randomForest11.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest11.input.importance.xls\")
dev.off()

###12
pdf(\"ANOVA.p0.05.randomForest12.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest12.input.importance.xls\")
dev.off()

###13
pdf(\"ANOVA.p0.05.randomForest13.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest13.input.importance.xls\")
dev.off()

###14
pdf(\"ANOVA.p0.05.randomForest14.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest14.input.importance.xls\")
dev.off()

###15
pdf(\"ANOVA.p0.05.randomForest15.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest15.input.importance.xls\")
dev.off()

###16
pdf(\"ANOVA.p0.05.randomForest16.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest16.input.importance.xls\")
dev.off()

###17
pdf(\"ANOVA.p0.05.randomForest17.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest17.input.importance.xls\")
dev.off()

###18
pdf(\"ANOVA.p0.05.randomForest18.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest18.input.importance.xls\")
dev.off()

###19
pdf(\"ANOVA.p0.05.randomForest19.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest19.input.importance.xls\")
dev.off()


###20
pdf(\"ANOVA.p0.05.randomForest20.input.pdf\",width =8,height =10 )
iris<-read.table(\"../ANOVA.p0.05.randomForest.input\",header=T,row.names=1)
iris = iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
set.seed(100)  
ind<-sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
traindata<-iris[ind==1,]
testdata<- iris[ind==2,]
n=length(traindata)

iris.rf=randomForest(type~.,iris[ind==1,],ntree=60,mtry=3,proximity=TRUE,importance=TRUE)
iris.rf\$importance
varImpPlot(iris.rf, main = \"Variable importance\")
write.table(iris.rf\$importance,file=\"ANOVA.p0.05.randomForest20.input.importance.xls\")
dev.off()


";

}
