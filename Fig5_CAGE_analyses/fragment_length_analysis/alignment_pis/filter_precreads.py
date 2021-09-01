import sys
file=open(sys.argv[1],"r")
for line in file:
    line=line.rstrip("\n")
    splitline=line.split("\t")
    if splitline[5]=="+" and (int(splitline[13])-int(splitline[1]))==2:
        print line
    elif splitline[5]=="-" and (int(splitline[2])-int(splitline[14]))==2:
        print line
file.close()


