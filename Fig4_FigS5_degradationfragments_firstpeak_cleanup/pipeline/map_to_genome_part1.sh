#!/bin/sh
#PBS -l walltime=10:00:00
#PBS -l select=1:ncpus=1:mem=8000000000

module load anaconda2/personal
module load cutadapt/1.10


cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_degradation_fragments/

cutadapt -a TGGAATTCTCGGGTGCCAAGGAA -o $FILE.trimmed $FILE
python /work/ab6415/scripts/fastq_2_FASTA.py $FILE.trimmed
python /work/ab6415/scripts/fasta_collapser_len_nt.py $FILE.trimmed.FASTA

