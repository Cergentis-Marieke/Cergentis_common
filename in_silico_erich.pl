#!/usr/bin/perl -w

use strict;

my $bam_file = shift @ARGV;
my $region = shift @ARGV;
my $outname = shift @ARGV;

warn $region." = region \n";
system 'samtools view '.$bam_file.' '."\"".$region."\""." | awk '{print \$1}' > ".$outname.'_names';
open NAMES, $outname.'_names' or die "Cannot open names: $!";

my %names;
while (my $name = <NAMES>){
	chomp $name;
	$names{$name}=1;
}


open BAM, 'samtools view '.$bam_file.' | ';
open SAM, '>'.$outname.".sam";
	

while(my $line = <BAM>){
	chomp $line;	
	my ($id) = (split /\t/, $line);
	if(defined $names{$id}){
		print SAM $line."\n";
	}
}

system 'samtools view -H '.$bam_file.' > '.$outname."_head";
system 'cat '.$outname.'_head '.$outname.'.sam > '.$outname.'_h.sam';
system 'samtools view -Sb '.$outname.'_h.sam > '.$outname.'.bam'; 
system "samtools index $outname".".bam"; 
system 'rm '.$outname."_head";
system 'rm '.$outname.'_h.sam';
system 'rm '.$outname.'.sam';
system 'rm '.$outname.'_names';

