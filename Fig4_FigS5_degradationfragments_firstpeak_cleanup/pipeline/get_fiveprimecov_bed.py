import sys
file=open(sys.argv[1],"r")
for line in file:
    line=line.rstrip("\n")
    line=line.split("\t")
    strand=line[5]
    if strand=="+":
        print(line[0]+"\t"+line[1]+"\t"+line[1]+"\t"+line[3]+"\t"+line[4]+"\t"+line[5])
    if strand=="-":
        print(line[0]+"\t"+line[2]+"\t"+line[2]+"\t"+line[3]+"\t"+line[4]+"\t"+line[5])
file.close()
