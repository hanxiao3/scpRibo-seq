#!/usr/bin/perl -w
my $version=1.00;

use strict;
use Getopt::Long;
use File::Basename;

my %opts;
GetOptions(\%opts,"a=s","b=s","o=s","h");
if (!(defined $opts{a} and defined $opts{b} and defined $opts{o}) || defined $opts{h}) { #necessary arguments
&usage;
}

open A,"<$opts{a}";
my %fpkm;
while (my $aline=<A>) {
chomp $aline;
my @arr=split /\s+/,$aline;
$fpkm{$arr[0]}=$arr[1];
}
close A;

open B,"<$opts{b}";
open OUT,">$opts{o}";
while (my $aline=<B>) {
chomp $aline;
my @arr=split /\s+/,$aline;
if (defined $fpkm{$arr[0]}) {
print OUT "$fpkm{$arr[0]}\t$aline\n";
}
}
close B;
close OUT;

sub usage{
print <<"USAGE";
Version $version
Description: LD decay plot.
Usage:
$0 -i -w -o
options:
-i input LD file #haploview output file
-w input window distance #default is 100bp
-h help
USAGE
exit(1);
}