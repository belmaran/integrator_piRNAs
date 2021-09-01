#run as "python get_smallRNA_counts.py input_sRNA_db.fa collapsed_reads.fa"
#generates small RNA counts table including the fasta header info, sequence, and number of reads

from __future__ import division
import sys
import re
import subprocess

inputmiRs = sys.argv[1]
inputseqs = sys.argv[2]

proc = subprocess.check_output('wc -l '+inputseqs,shell=True)
#print proc
totalcount = int(proc.split(" ")[0])

seqs = open(inputseqs,"r")
miRs = open(inputmiRs,"r")

#hash miRNAs (key=miR sequence, value=empty list[])

miRhash = {}

for line in miRs:
	line = line.rstrip("\r\n")
	if line.startswith(">"):
		miRNA_id = line.replace(">","")
	if not line.startswith(">"):
                line=line.rstrip("\n")
                miRhash[line]=miRNA_id
miRs.close()



#scan reads and print miRNA matching reads

ismiR=False

for line in seqs:
	if line.startswith(">"):
		id = line.rstrip("\n")
                id=id.replace(">","")
	else:
                line=line.rstrip("\n")
		if line in miRhash:
			print id+"\t"+miRhash[line]+"\t"+line.rstrip("\n")




