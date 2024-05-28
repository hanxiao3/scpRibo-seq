#!/usr/perl/bin
###merge one row  with the same id
###example:perl merge.pl -column1 1 -column2 2 -file a,b,c -o tes
use Getopt::Long;

my %opts;
GetOptions(\%opts,"column1=i","column2=i","file=s","o=s");
@files=split(/,/,$opts{file});

$id=$opts{column1}-1;
$tmp=$opts{column2}-1;
$n=0;
foreach $f (@files){
open(IN,"$f");
$n++;
$label{$n}=$f;
while($a=<IN>){
chomp;

@aline=split(/\t/,$a);

$myid=$aline[$id];
$mytmp=$aline[$tmp];
chomp($mytmp);
chomp($myid);
$allid{$myid}=1;
if(defined $hash{$n}{$myid}){
        $hash{$n}{$myid}=$mytmp;
 
                        }
   else {
       
       $hash{$n}{$myid}=$mytmp;
        }


           }



                   }


open(OUT,">$opts{o}");
print OUT "id\t";
for($j=1;$j<=$n;$j++){
if($j==$n){print OUT "$label{$j}\n";}
  else {print OUT "$label{$j}\t";}

}
foreach $key (keys %allid){
print OUT "$key\t"; 
for($i=1;$i<=$n;$i++){
  if(defined $hash{$i}{$key}){
 
     print OUT "$hash{$i}{$key}";
                             }
  
      else {

      print OUT "0"; 

           }
   if($i==$n) 
            {
             print OUT "\n";
            }
         else {
              print OUT "\t";
              }


                          }




                          }









