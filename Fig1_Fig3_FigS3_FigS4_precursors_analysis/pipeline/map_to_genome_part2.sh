#!/bin/sh                                                                                              
#PBS -l walltime=10:00:00                                                                                              
#PBS -l select=1:ncpus=1:mem=8000000000

module load bowtie/0.12.1
module load samtools/1.2
module load bedtools/2.25.0
module load R

cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_longreads_fractionation_rep2/

for file in *len_nt_collapsed;
do
    
    file=${file%.FASTA_len_nt_collapsed}

    echo $file

    bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_genome \
	-f $file.FASTA_len_nt_collapsed -v 0 -S > $file.sam;
    
    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.bed;
    samtools view -b -f4 $file.bam > $file.unmapped.bam
    rm $file.sam;
    rm $file.bam;

    sort $file.bed > $file.sorted.bed;
    rm $file.bed;

    python /work/ab6415/scripts/first_ntab_simple_uncol_bed.py $file.sorted.bed;
    Rscript /work/ab6415/scripts/plot_firstntab.R $file.sorted.bed.firstntab_col.csv $file.firstntab_col.png;
    Rscript /work/ab6415/scripts/plot_firstntab.R $file.sorted.bed.firstntab_unc.csv $file.firstntab_unc.png;

done
