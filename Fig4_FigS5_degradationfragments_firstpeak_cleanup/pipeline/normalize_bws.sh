#!/bin/sh                                                                                              
#PBS -l walltime=10:00:00                                                                                              
#PBS -l select=1:ncpus=32:mem=124gb


module load anaconda3/personal

cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_degradation_fragments_nopis_or_peak1_21Us

bamCoverage -b Sample_14_N2_EV_dir_S1_L006_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_14_N2_EV_dir_S1_L006_R1_001.fastq.trimmed.nopis.bw -p 32  -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_15_N2_I_dir_S2_L006_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_15_N2_I_dir_S2_L006_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_16_TFIIS_EV_dir_S3_L006_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_16_TFIIS_EV_dir_S3_L006_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_17_TFIIS_I_dir_S4_L006_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_17_TFIIS_I_dir_S4_L006_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_17_N2_EV_dir_S67_L007_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_17_N2_EV_dir_S67_L007_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_18_N2_Ints11_dir_S68_L007_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_18_N2_Ints11_dir_S68_L007_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_19_TFIIS_EV_dir_S69_L007_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_19_TFIIS_EV_dir_S69_L007_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM

bamCoverage -b Sample_20_TFIIS_Ints11_dir_S70_L007_R1_001.fastq.trimmed.nopis.sorted.bam \
-o cpm_normalized_bws/Sample_20_TFIIS_Ints11_dir_S70_L007_R1_001.fastq.trimmed.nopis.bw -p 32 -bs 1 --normalizeUsing CPM



cd /rds/general/user/ab6415/projects/lms-sarkies-analysis/live/Toni/integrator_degradation_fragments_nopis_or_peak1_21Us/cpm_normalized_bws/

computeMatrix reference-point \
-S Sample_14_N2_EV_dir_S1_L006_R1_001.fastq.trimmed.nopis.bw Sample_15_N2_I_dir_S2_L006_R1_001.fastq.trimmed.nopis.bw Sample_16_TFIIS_EV_dir_S3_L006_R1_001.fastq.trimmed.nopis.bw Sample_17_TFIIS_I_dir_S4_L006_R1_001.fastq.trimmed.nopis.bw Sample_17_N2_EV_dir_S67_L007_R1_001.fastq.trimmed.nopis.bw Sample_18_N2_Ints11_dir_S68_L007_R1_001.fastq.trimmed.nopis.bw Sample_19_TFIIS_EV_dir_S69_L007_R1_001.fastq.trimmed.nopis.bw Sample_20_TFIIS_Ints11_dir_S70_L007_R1_001.fastq.trimmed.nopis.bw \
-R all_pis_typeI.nomtDNA.bed \
-bs 1 -a 100 -b 50 -p 32 \
-o all_pis_typeI.cpm.matrix

plotHeatmap -m all_pis_typeI.cpm.matrix -o all_pis_typeI.cpm.matrix.pdf

bigwigCompare -b1 Sample_14_N2_EV_dir_S1_L006_R1_001.fastq.trimmed.nopis.bw -b2 Sample_17_N2_EV_dir_S67_L007_R1_001.fastq.trimmed.nopis.bw --operation mean -o N2_EV_avg.bw -bs 1 -p 32
bigwigCompare -b1 Sample_15_N2_I_dir_S2_L006_R1_001.fastq.trimmed.nopis.bw -b2 Sample_18_N2_Ints11_dir_S68_L007_R1_001.fastq.trimmed.nopis.bw --operation mean -o N2_ints11RNAi_avg.bw -bs 1 -p 32
bigwigCompare -b1 Sample_16_TFIIS_EV_dir_S3_L006_R1_001.fastq.trimmed.nopis.bw -b2 Sample_19_TFIIS_EV_dir_S69_L007_R1_001.fastq.trimmed.nopis.bw --operation mean -o TFIIS_EV_avg.bw -bs 1 -p 32
bigwigCompare -b1 Sample_17_TFIIS_I_dir_S4_L006_R1_001.fastq.trimmed.nopis.bw -b2 Sample_20_TFIIS_Ints11_dir_S70_L007_R1_001.fastq.trimmed.nopis.bw --operation mean -o TFIIS_ints11RNAi_avg.bw -bs 1 -p 32

computeMatrix reference-point \
-S N2_EV_avg.bw N2_ints11RNAi_avg.bw TFIIS_EV_avg.bw TFIIS_ints11RNAi_avg.bw \
-R all_pis_typeI.nomtDNA.bed \
-bs 1 -a 100 -b 50 -p 32 \
-o all_pis_typeI.avg.cpm.matrix

plotHeatmap -m all_pis_typeI.avg.cpm.matrix -o all_pis_typeI.avg.cpm.matrix.pdf


