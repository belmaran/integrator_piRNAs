import sys
file=open(sys.argv[1],"r")

pis=set()

for line in file:
    if line.startswith(">"):
        pass
    else:
        line=line.rstrip("\n")
        pis.add(line[0:21])
file.close()


totalcount=0
totalseqs=0

readsfile=open(sys.argv[2],"r")
for line in readsfile:
    line=line.rstrip("\n")
    if line.startswith(">"):
        id=line
    else:
        seq=line
        if seq in pis:
            id=id.split(",")
            totalcount=totalcount+int(id[2])
            totalseqs=totalseqs+1
readsfile.close()

print totalcount
print totalseqs
