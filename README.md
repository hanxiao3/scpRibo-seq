# scpRibo-seq
Blastomeres classification at 2-cell stages

I. Preparation of the input files and other necessary files. (All input files, input.txt, ID_genename, group_list, hashmatch.pl, and merge.pl)
1) The input file contains the gene names and reads count or RPKM for each sample. The corresponding input.txt file for the input contains the relationship between two blastomeres in an embryo. For example, if p1-5 represent 5 embryos, '_1' and '_2' represent the two blastomeres, then the input.txt file would be:

p1_1	p1_2
p2_1	p2_2
p3_1	p3_2
p4_1	p4_2
p5_1	p5_2

3) ID_genename:The first column contains gene IDs, and the second column contains gene names.

4) group_list: The labels for sample classification. For example, if there are 5 embryos with a total of 10 samples, the group_list would be:
   
Cluster1
Cluster1
Cluster1
Cluster1
Cluster1
Cluster2
Cluster2
Cluster2
Cluster2
Cluster2

II. Generate the required script and different combinations of blastomeres.

1) perl Random_sampling.pl N Random_sampling.list
2) perl ANOVA.r.pl
3) perl RandomForest.r.pl
4) perl Heatmap.r.pl
5) perl Wilcox.r.pl

###Note:
The Random_sampling.pl file generates all possible combinations of blastomeres. The parameter N is determined by taking 2 raised to the power of (n-1) and then adding 1 (where n is the number of embryos). If n is 5, the command would be:

perl Random_sampling.pl 17 Random_sampling.list

III. Initial screening of differential genes in different blastomere groups, feature selection using random forest (example with 20 repetitions per group), and determination of the optimal combination of blastomeres.
The code uses 10 samples from 5 embryos as an example.

perl All.pl

###Note:
1. Intermediate statistical files generated during the calculation process can aid in data evaluation. After the calculation is completed, merge the Standard_test.result files from each group to select the optimal group. To obtain stable results, it is recommended to repeat the above steps at least 100 times in batches(depending on the number of embryos and samples).
2. Adjustable parameters in the script include: the significance p-value for ANOVA to preliminarily screen potential differential genes, the number of top significant genes selected in each round of feature calculation, MDA value, pearson correlation coefficient within and between groups, and the number of feature items with actual significant differences (p < 0.05).

