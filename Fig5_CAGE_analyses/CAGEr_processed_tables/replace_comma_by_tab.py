import sys

file=open(sys.argv[1],"r")
outfile=open(sys.argv[1]+"_replaced","w")

for line in file:
	outfile.write(line.replace(',','\t'))

file.close()
outfile.close()
