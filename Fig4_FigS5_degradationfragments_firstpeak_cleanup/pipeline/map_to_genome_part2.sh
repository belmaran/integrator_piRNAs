#!/bin/sh                                                                                              
#PBS -l walltime=10:00:00                                                                                              
#PBS -l select=1:ncpus=1:mem=8000000000

#wrapper shell script for small RNA mapping of uncollapsed libraries QC and annotation of the mapped 
#reads

#you need to start out with all the fasta files that need to be mapped in a directory
#maps to the whole genome of C. elegans and then retrieves annotation of the mapped reads

module load bowtie/0.12.1
module load samtools/1.2
module load bedtools/2.25.0
module load R

cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_degradation_fragments_nopis_or_peak1_21Us/

for file in *col.fa.filtered ;
do
    
    file=${file%.col.fa.filtered}

    echo $file

    bowtie /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/reference_sequences/c_elegans/indexes/cel_genome \
	-f $file.col.fa.filtered -v 0 -S > $file.sam;
    
    samtools view -bS $file.sam > $file.bam;
    bedtools bamtobed -i $file.bam > $file.bed;
    samtools view -b -f4 $file.bam > $file.unmapped.bam
    rm $file.sam;
    
    samtools sort $file.bam $file.sorted
    samtools index $file.sorted.bam

done


for file in *bed ; python get_fiveprimecov_bed.py $file > $file.5primeends ; done
for file in *sorted.bed.5primeends ; do echo $file ; sort -k1,1 -k2,2n $file > | awk '$13<11' > $file.resorted ; done
