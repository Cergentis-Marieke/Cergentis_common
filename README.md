# Cergentis_common
This repository contains basic scripts for TLA data processing
For info on Targeted Locus Amplification (TLA) see www.cergentis.com
For questions about the scripts, please contact info@cergentis.com

--------------------------------------------------------------------------------------------------


## Generating images of TLA coverage accross the genome:

This set of scripts is designed to produce an image of the coverage accross the genome as generated in a TLA experiment. THis will whow the peak of coverage at the primer locations, or in case of analyses of transgenic samples, the integration site of the analysed transgenic sequence.
The script take as input a folder that contains all the bam files for which the image should be created. for each of the bams in teh input folder, the scripts will generate two output files: a list of the coverage per 10kb bins (txt), and an image of the coverage (png).

Installation:  
download following scripts and store wihtin one folder:  
-plotGenomeCoverage.pl  
-windowed_coverage.pl  
-GenomePlot.R  

Requirements:
-R (version 2.14.1 or higher) http://cran.r-project.org/
-Samtools, installed in PATH (version 0.1.18 or higher), download and installation instructions at: http://samtools.sourceforge.net/

Usage: 
Run plotGenomeCoverage.pl (this will call windowed_coverage.pl, and GenomePlot.R)
plotGenomeCoverage.pl -i <input_folder>  -o <output-folder>
options:
-h :print help page
-i :directory that contains the bam files 
-o :directory to which the output will be written. 
This directory needs to exist before this tool is used.  It will not be created automatically 
>
--------------------------------------------------------------------------------------------------------
## Selecting all reads from a genomic region of interest, and selecting their mates (paired-end reads). 

In TLA data, DNA has been fragmented and religated based on proximity ligation. The two mates of a paired-end read will originate from the same allele (same physical copy of the locus of interest), but the genomic distance between the alignment postions of the two mates can range from 1 bp to the span of an entire chromosome. By comparing the locations of mates, information is obtained on the relative location of DNA loci. If many different paired-end read mates are found that link two loci, the two loci are expected to be found in close proximity to each other in the genome. 
The in_silico_enrich.pl script selects all reads, and the corresponding mates from a region of interest. The mates will be informative to identify which genomic regions are postioned close to the region of interest (for example to identify large structural variations).

usage example:
in_silico_enrich.pl my_data.bam chr1:3000000-3500000 my_output_name_prefix
This will genrate a bam file named my_output_name_prefix.bam and a corresponding .bai

dependencies:
-requires samtools in PATH
-uses awk

Was designed to work on paired-end files, aligned in single end mode (aligning each mate file seperately and subsequently merging the files).







