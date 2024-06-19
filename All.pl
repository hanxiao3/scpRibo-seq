#!/usr/perl/bin
open(IN,"Random_sampling.list");
$n=0;
system ("mkdir shell.all");
chomp(@fqs=<IN>);
foreach $fq (@fqs) {
$n++;
$name="group_".$n;
$fq =~/(\S+)\t(\S+)/;

open(OUT,">./shell.all/$1.sh");

print OUT "
###The code uses 10 samples from 5 embryos as an example.
data=/workpath
###1-Generate a matrix of different combinations of blastomeres.
cd \${data}
mkdir $name
perl merge.pl -column1 1 -column2 2 -file $2 -o ./$name/ANOVA.input


###2-Initial screening of differential genes in different blastomere groups
cd \${data}/shell.ANOVA
Rscript $name.R

cd \${data}/$name
awk '\$13<0.05' ANOVA.out| cut -f1-11 | sed '1i ID\\t$2'| sed 's/,/\\t/g'>  ANOVA.p0.05
sed '\$a\\type\\tA\\tA\\tA\\tA\\tA\\tB\\tB\\tB\\tB\\tB' ANOVA.p0.05|awk '!/^\$/'| awk '{for(i=1;i<=NF;i++){a[FNR,i]=\$i}}END{for(i=1;i<=NF;i++){for(j=1;j<=FNR;j++){printf a[j,i]\" \"}print \"\"}}'  | sed 's/ /\\t/g' | sed 's/\\r//g' | sed 's/[ \\t]*\$//g'> ANOVA.p0.05.randomForest.input
rm ANOVA.a 
sed '1d' ANOVA.p0.05 | wc -l | awk '{print \"ANOVA\"\"\\t\"\$0}'> filter.genecount

###3-Feature selection using random forest (example with 20 repetitions per group)
###Select the top 30 significant feature genes for downstream analysis. This parameter can be adjusted.
cd \${data}/$name
mkdir randomForest

cd \${data}/shell.randomForest
Rscript $name.R

cd \${data}/$name
for i in {1..20} #replace n with the total number of samples you have
do
  input_file=\"./randomForest/ANOVA.p0.05.randomForest\${i}.input.importance.xls\"
  output_file=\"randomForest\${i}\"

  sed '1d' \$input_file | sed 's/ /\\t/g' | cut -f1-4 | sed 's/\"//g' | awk 'BEGIN{OFS=FS=\"\\t\"} {printf \"%s\\t%s\\t%s\\t%.20f\\n\", \$1, \$2, \$3, \$4}'| sort -k4,4nr | head -30 | awk '\$4>0 {print \$1\"\\t\"\$4}' > \$output_file
done


for i in {1..20}; do
  less -S randomForest\$i | wc -l | awk -v name=\"randomForest\$i\" '{print name \"\\t\" \$0 \"\\t\" name}' >> filter.RandomForest.genecount
done

for i in {1..20}; do
  less -S randomForest\$i | awk '{print \"randomForest\$i\"\"\\t\"\$0\"\\t\"\"$name\"}' >> filter.RamdomForest20.MDA
done

perl merge.pl -column1 1 -column2 2 -file randomForest1,randomForest2,randomForest3,randomForest4,randomForest5,randomForest6,randomForest7,randomForest8,randomForest9,randomForest10,randomForest11,randomForest12,randomForest13,randomForest14,randomForest15,randomForest16,randomForest17,randomForest18,randomForest19,randomForest20 -o merge.randomForest20s
sed '1d' merge.randomForest20s | wc -l |  awk '{print \"RamdomForest_total\"\"\\t\"\$0}' >> filter.genecount

####At least one gene is selected more than 5 times, it is considered a potential feature.
cd \${data}/$name

for i in {1..20}; do
  less -S ./randomForest/ANOVA.p0.05.randomForest\${i}.input.importance.xls | sed 's/ /\\t/g'| cut -f1-4 | sed 's/\"//g'| awk 'BEGIN{OFS=FS=\"\\t\"} {printf \"%s\\t%s\\t%s\\t%.20f\\n\", \$1, \$2, \$3, \$4}' | sort -k4,4nr | head -30 | awk '\$4>0 {print \$1}' >> a1
done

sort a1| uniq -c |awk '{sub(/^ */,\"\");sub(/ *\$/,\"\")}1' | sed 's/ /\\t/g' | awk '{print \$2\"\\t\"\$1}'| sort -k2,2rn > randomForest.gene_frequency
rm a1
awk '{print \"Most_freq\"\"\\t\"\$2\"\\t\"\"$name\"}' randomForest.gene_frequency | head -1> randomForest.Most_freq
awk '\$2>=5 {print \$1}' randomForest.gene_frequency | awk '{if(NR==FNR){a[\$1]}else if(\$1 in a)print \$0}' - merge.randomForest20s | cut -f1 > head 
awk '\$2>=5 {print \$1}' randomForest.gene_frequency | awk '{if(NR==FNR){a[\$1]}else if(\$1 in a)print \$0}' - merge.randomForest20s |sed '1i ID\\trandomForest1\\trandomForest2\\trandomForest3\\trandomForest4\\trandomForest5\\trandomForest6\\trandomForest7\\trandomForest8\\trandomForest9\\trandomForest10\\trandomForest11\\trandomForest12\\trandomForest13\\trandomForest14\\trandomForest15\\trandomForest16\\trandomForest17\\trandomForest18\\trandomForest19\\trandomForest20'| awk '{for(i=1;i<=NF;i++){a[FNR,i]=\$i}}END{for(i=1;i<=NF;i++){for(j=1;j<=FNR;j++){printf a[j,i]\" \"}print \"\"}}' | sed 's/ /\\t/g' | awk 'NR>1' | awk '{for(i=2;i<=NF;i++)a[i]+=\$i;print}END{printf \"TOTAL \\t\";for(j=2;j<=NF;j++)printf a[j]\"\\t\"; print\"\"}' | tail -1 | awk '{for(i=1;i<=NF;i++){a[FNR,i]=\$i}}END{for(i=1;i<=NF;i++){for(j=1;j<=FNR;j++){printf a[j,i]\" \"}print \"\"}}'| sed 's/ /\\t/g' | awk 'NR > 1' | paste head - | sed 's/ /\\t/g' > a1 
awk '\$2>=5 {print \$0}' randomForest.gene_frequency > a2 
perl ../merge.pl -column1 1 -column2 2 -file  a1,a2 -o a3
sed '1d' a3 | awk '{print \$1\"\\t\"(\$2/\$3)}' | sort -k2,2nr> randomForest.freq_over5.MDA

rm a1 a2 a3  head randomForest1 randomForest2 randomForest3 randomForest4 randomForest5 randomForest6 randomForest7 randomForest8 randomForest9 randomForest10 randomForest11 randomForest12 randomForest13 randomForest14 randomForest15 randomForest16 randomForest17 randomForest18 randomForest19 randomForest20
less -S randomForest.freq_over5.MDA | wc -l | awk '{print \"RamdomForest_freq_over5\"\"\\t\"\$0}' >> filter.genecount
cat randomForest.freq_over5.MDA|awk '{sum+=\$2} END {print \"Average\"\"\\t\"sum/NR}' > MDA.mean.median

cut -f1 randomForest.freq_over5.MDA | awk '{if(NR==FNR){a[\$1]}else if(\$1 in a)print \$0}' -  ANOVA.p0.05 |  sed '1i ID\\t$2' | sed 's/,/\\t/g'> randomForest.freq_over5.MDA.finaltrans_RPKM
perl hashmatch.txt -a ID_genename -b randomForest.freq_over5.MDA.finaltrans_RPKM -o a1
cut -f1,3-12 a1|  sed '1i ID\\t$2' | sed 's/,/\\t/g'>  randomForest.freq_over5.MDA.genename.finaltrans_RPKM
rm a1

perl hashmatch.txt -a ID_genename -b randomForest.freq_over5.MDA -o a1
cut -f1,3 a1>  randomForest.freq_over5.genename.MDA
less -S randomForest.freq_over5.genename.MDA |  awk '{print \$0\"\\t\"\"$name\"}' > randomForest.freq_over5.MDA.ggplot
rm a1

###Significance calculation
cd \${data}/$name
cut -f1-6 randomForest.freq_over5.MDA.genename.finaltrans_RPKM > a1 
cut -f1,7-11 randomForest.freq_over5.MDA.genename.finaltrans_RPKM  > a2
sed '1d' randomForest.freq_over5.MDA.genename.finaltrans_RPKM | cut -f1 > a3 

cd \${data}/shell.wilcox
Rscript $name.R

cd \${data}/$name
rm a1 a2 a3 
sed 's/\"//g' wilcox.test.pvalue | sed 's/ /\\t/g' | awk '\$2<0.05 {print \$0\"\\t\"\"$name\"}' > randomForest.freq_over5.MDA.genename.pvalue0.05
less -S randomForest.freq_over5.MDA.genename.pvalue0.05 | wc -l | awk '{print \"RamdomForest_freq_over5_p0.05\"\"\\t\"\$0}' >> filter.genecount
cut -f1 randomForest.freq_over5.MDA.genename.pvalue0.05 | awk '{if(NR==FNR){a[\$1]}else if(\$1 in a)print \$0}' - randomForest.freq_over5.MDA.genename.finaltrans_RPKM |  sed '1i ID\\t$2' | sed 's/,/\\t/g' > randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM

#####Cluster analysis
cd \${data}/shell.heatmap
Rscript $name.R

cd \${data}/$name
sed '1d' randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.tree.txt | sed 's/\"//g' | sed 's/ /\\t/g' |  awk '{for(i=1;i<=NF;i++){a[FNR,i]=\$i}}END{for(i=1;i<=NF;i++){for(j=1;j<=FNR;j++){printf a[j,i]\" \"}print \"\"}}' | sed 's/ /\\t/g' |sed '\$a\\A\\tA\\tA\\tA\\tA\\tB\\tB\\tB\\tB\\tB' |awk '{for(i=1;i<=NF;i++){a[FNR,i]=\$i}}END{for(i=1;i<=NF;i++){for(j=1;j<=FNR;j++){printf a[j,i]\" \"}print \"\"}}' | sed 's/ /\\t/g' | sed '1i ID\\ttree\\torigin_group'> Tree.cluster
sed '1d' Tree.cluster | awk '{print \$1\"\\t\"\$2\"_\"\$3}' | grep -v '2_A'| grep -v '1_B' | wc -l |awk '{print \"Correct_cluster\"\"\\t\"\$0\"\\t\"(\$0/10)\"\t\"\"$name\"}' > a
sed '1d' Tree.cluster | awk '{print \$1\"\\t\"\$2\"_\"\$3}' | grep -v '1_A'| grep -v '2_B' | wc -l |awk '{print \"Correct_cluster\"\"\\t\"\$0\"\\t\"(\$0/10)\"\\t\"\"$name\"}' > b 
cat a b| sort -k3,3nr | head -1 > Tree.cluster.Accuracy
rm a b 

####
cd \${data}/$name
sed 's/ /\\t/g' randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.txt | head -5 | cut -f1-5 | sed 's/\\t/\\n/g' |sort -k1,1nr |awk 'NR>5'| sort | uniq | awk ' {print \"ClusterA\"\"\\t\"\$0\"\\t\"\"$name\"}' >  cluster.pearson.ggplot
sed 's/ /\\t/g' randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.txt | head -5 | cut -f6-10 | sed 's/\\t/\\n/g' | sort | uniq |awk ' {print \"Between_cluster\"\"\\t\"\$0\"\\t\"\"$name\"}' >>  cluster.pearson.ggplot
sed 's/ /\\t/g' randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.txt | tail -5 | cut -f1-5 | sed 's/\\t/\\n/g' | sort | uniq |awk ' {print \"Between_cluster\"\"\\t\"\$0\"\\t\"\"$name\"}' >>  cluster.pearson.ggplot
sed 's/ /\\t/g' randomForest.freq_over5.MDA.p0.05.finaltrans_RPKM.cor.txt | tail -5 | cut -f6-10 | sed 's/\\t/\\n/g' |sort -k1,1nr |awk 'NR>5'| sort | uniq | awk ' {print \"ClusterB\"\"\\t\"\$0\"\\t\"\"$name\"}' >>  cluster.pearson.ggplot


###Judging criteria (These parameters can be adjusted.):
###MDA > 0 in each circulation
###Genes that been identified in each circulation occurs at least 5 times are considering as feature items. Average MDA > 0.012;
###Blastomere derived from different embryos with common features cluster together.
###Pearson correlation coefficient: Within one groups: > 0.5; -0.2< Between two groups< 0.6; 
###Feature items with actual significance differences  (p < 0.05) > 10

cd \${data}/$name 
awk '{if(\$2> 0.01){print \"1_MDA_average\"\"\\t\"\"Yes\"}else {print \"1_MDA_average\"\"\\t\"\"No\"}}' MDA.mean.median>Standard_test.result
awk '{if(\$3==1){print \"2_Correct_cluster\"\"\\t\"\"Yes\"}else {print \"2_Correct_cluster\"\"\\t\"\"No\"}}' Tree.cluster.Accuracy>>Standard_test.result
awk '\$1==\"ClusterA\" ||\$1==\"ClusterB\" {print \$2}' cluster.pearson.ggplot | awk '{sum+=\$1} END {print sum/NR}' | awk '{if(\$1> 0.5){print \"3_cluster.pearson_inner_ave\"\"\\t\"\"Yes\"}else {print \"3_cluster.pearson_inner_ave\"\"\\t\"\"No\"}}'>>Standard_test.result
awk '\$1==\"ClusterA\" ||\$1==\"ClusterB\" {print \$2}' cluster.pearson.ggplot |sort -k1,2nr| tail -1  | awk '{if(\$1> 0.2){print \"4_cluster.pearson_inner_all\"\"\\t\"\"Yes\"}else {print \"4_cluster.pearson_inner_all\"\"\\t\"\"No\"}}'>>Standard_test.result
awk '\$1==\"Between_cluster\" {print \$2}' cluster.pearson.ggplot  | sort -k1,2nr| tail -1 | awk '{if(\$1>-0.2){print \"5_cluster.pearson_between_min\"\"\\t\"\"Yes\"}else {print \"5_cluster.pearson_between_min\"\"\\t\"\"No\"}}'>>Standard_test.result
awk '\$1==\"Between_cluster\" {print \$2}' cluster.pearson.ggplot  | sort -k1,2nr| head -1 | awk '{if(\$1< 0.6){print \"6_cluster.pearson_between_max\"\"\\t\"\"Yes\"}else {print \"6_cluster.pearson_between_max\"\"\\t\"\"No\"}}'>>Standard_test.result
less -S randomForest.freq_over5.MDA.genename.pvalue0.05 | wc -l |  awk '{if(\$1>15){print \"7_feasure_items_p0.05\"\"\\t\"\"Yes\"}else {print \"7_feasure_items_p0.05\"\"\\t\"\"No\"}}'>>Standard_test.result

";

}
