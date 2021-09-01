#!/bin/sh
#PBS -l walltime=10:00:00
#PBS -l select=1:ncpus=1:mem=8000000000

module load samtools/1.2
module load cutadapt/1.10

cd /csc/analysis/Sarkies/Toni/integrator_smallRNAs_GTBT

cutadapt -a TGGAATTCTCGGGTGCCAAGGAA -m 18 -o $FILE.trimmed $FILE
python /work/ab6415/scripts/fastq_2_FASTA.py $FILE.trimmed
python /work/ab6415/scripts/fasta_collapser_len_nt.py $FILE.trimmed.FASTA

