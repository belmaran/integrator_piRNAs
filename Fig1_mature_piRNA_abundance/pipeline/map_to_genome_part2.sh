#!/bin/sh                                                                                              
#PBS -l walltime=10:00:00                                                                                              
#PBS -l select=1:ncpus=1:mem=8000000000

module load bowtie/0.12.1
module load samtools/1.2
module load bedtools/2.25.0

cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_smallRNAs_GTBT/

for file in *len_nt_collapsed;
do
    
    file=${file%.FASTA_len_nt_collapsed}

    echo $file

    bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_genome \
	-f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;
    
    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.bed;
    rm $file.sam;
    rm $file.bam;

    sort $file.bed > $file.sorted.bed;
    rm $file.bed;

    python /work/ab6415/scripts/first_ntab_simple_uncol_bed.py $file.sorted.bed;
    Rscript /work/ab6415/scripts/plot_firstntab.R $file.sorted.bed.firstntab_col.csv $file.firstntab_col.png;
    Rscript /work/ab6415/scripts/plot_firstntab.R $file.sorted.bed.firstntab_unc.csv $file.firstntab_unc.png;


    python /work/ab6415/scripts/get_smallRNA_counts.py $ANALYSIS/reference_sequences/c_elegans/sequence_files/All_piRNAs_new_reference.fasta $file.FASTA_len_nt_collapsed > $file.piRNAcounts
    python /work/ab6415/scripts/get_smallRNA_counts.py $ANALYSIS/reference_sequences/c_elegans/sequence_files/cel_mature_miRNAs.fa_toT.fasta $file.FASTA_len_nt_collapsed > $file.miRNAcounts
	
done
