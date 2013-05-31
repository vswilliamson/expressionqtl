#!/usr/local/bin/perl
use strict;
use warnings;
my $file = shift;
my $genotype = shift;
if(!defined($genotype)){
         die "snplist genotypes\n";
}
 my %geno;
open GEN, $genotype;
        while (my $line = <GEN>){
                 chomp $line;
                        if ($line=~/(rs\d+)\tchr\S+\t\d+\t\d{1}\t\d{1}.*/){
                               $geno{$1} = $line;
                        }
        }
  my $snp;
 open FH, $file;
        while (my $line = <FH>){
                 chomp $line;
                        if ($line =~/(\S+)/){
                            $snp = $1;
                            if (exists $geno{$snp}){
                                 print "$geno{$snp}\n";
                            }
                            if (!exists $geno{$snp}){
                                print "\n";
                            }
                        }
        }
