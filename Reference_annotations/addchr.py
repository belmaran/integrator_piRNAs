import sys
file=open(sys.argv[1],"r")
for line in file:
    line=line.rstrip("\n")
    print "chr"+line.replace("MtDNA","M")
file.close()

        
