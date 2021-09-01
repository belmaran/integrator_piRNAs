#!/bin/sh                                                                                                                          
#PBS -l walltime=72:00:00                                                                                                          
#PBS -l select=1:ncpus=1:mem=96gb
#map to structural RNAs

module load bowtie/0.12.1
module load samtools/1.2
module load bedtools/2.25.0

cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_smallRNAs_GTBT/

for file in *len_nt_collapsed;
do

    file=${file%.FASTA_len_nt_collapsed}

    echo $file

    bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_rRNA \
        -f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;

    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.rRNA.bed;
    rm $file.sam;
    rm $file.bam;

    sort $file.rRNA.bed > $file.sorted.rRNA.bed;
    rm $file.rRNA.bed;


   bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_tRNAs \
       -f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;

    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.tRNA.bed;
    rm $file.sam;
    rm $file.bam;

    sort $file.tRNA.bed > $file.sorted.tRNA.bed;
    rm $file.tRNA.bed;


   bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_snRNAs \
       -f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;

    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.snRNA.bed;
    rm $file.sam;
    rm $file.bam;

    sort $file.snRNA.bed > $file.sorted.snRNA.bed;
    rm $file.snRNA.bed;


   bowtie /csc/analysis/Sarkies/Toni/reference_sequences/c_elegans/indexes/cel_snoRNAs \
       -f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;

    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.snoRNA.bed;
    rm $file.sam;
    rm $file.bam;

    sort $file.snoRNA.bed > $file.sorted.snoRNA.bed;
    rm $file.snoRNA.bed;


done
