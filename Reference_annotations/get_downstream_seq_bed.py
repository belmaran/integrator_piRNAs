import sys
bed=open(sys.argv[1],"r")
for line in bed:
    line=line.rstrip("\n")
    splitline=line.split("\t")
    strand=splitline[5]
    start=int(splitline[1])
    end=int(splitline[2])

    if strand=="+":
        print splitline[0]+"\t"+str(end)+"\t"+str(end+30)+"\t"+splitline[3]+"\t"+splitline[4]+"\t"+strand
    elif strand=="-":
        print splitline[0]+"\t"+str(start-30)+"\t"+str(start)+"\t"+splitline[3]+"\t"+splitline[4]+"\t"+strand
bed.close()
