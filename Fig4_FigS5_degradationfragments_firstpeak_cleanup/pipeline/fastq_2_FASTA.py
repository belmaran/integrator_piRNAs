import sys

inputstring = sys.argv[1]
infile = open(inputstring,"r")
outfile= open(inputstring+".FASTA","w")

count=0
for line in infile:
	count = count +1
	if count%4 == 1:
		outfile.write(line.replace("@",">"))
	if count%4 == 2:
		outfile.write(line)

infile.close()
outfile.close()
