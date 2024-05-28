#!/usr/perl/bin
open(IN,"input.txt");
open(OUT,">$ARGV[2]") or die "1";
$cut= $ARGV[0];
$pair= $ARGV[1];
while(<IN>){
chomp;
@aline=split(/\t/,$_);
$pair{$aline[0]}=$aline[1];
$pair{$aline[1]}=$aline[0];

push(@all,$aline[0]);
push(@all,$aline[1]);

}

$num=$#all+1;
$out=0;
$line=1;
while($line<$cut){
$out=0;
$use=();
$info1=();
%nouse=();
%myuse=();
@out1=();
@out2=();

while($out<$pair){

$use=int(rand($num)-1);

$info1=$all[$use];

if(defined ($nouse{$info1})){
next;
}


else {
$nouse{$pair{$info1}}=1;
$nouse{$info1}=1;
$myuse{$info1}=1;
push (@out1,$info1); push (@out2,$pair{$info1});
$out++;

}

}
$out1=join(",",@out1);
$out2=join(",",@out2);
@labelout=sort{$a cmp $b}(@out1);
$labelout=join(",",@labelout);
if(defined $outhash{$labelout}){
next;
}
else {

$outhash{$labelout}=1;
print  OUT  "group_$line\t$out1,$out2\n";
$line++;
}
}



