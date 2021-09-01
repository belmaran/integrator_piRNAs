
import sys

id=sys.argv[1]
file = open(id,"r")

A_unc=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
C_unc=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
G_unc=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
T_unc=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

A_col=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
C_col=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
G_col=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
T_col=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

for line in file:
	line=line.split("\t")
	length=int(line[3].split(",")[0])
	nt=line[3].split(",")[1]
	times=int(line[3].split(",")[2])

	if length < 51 and length > 14:
		if nt=="A":
			A_col[length-15]=A_col[length-15]+1
                	A_unc[length-15]=A_unc[length-15]+times
        	if nt=="C":
                	C_col[length-15]=C_col[length-15]+1
                	C_unc[length-15]=C_unc[length-15]+times        
		if nt=="G":
                	G_col[length-15]=G_col[length-15]+1
                	G_unc[length-15]=G_unc[length-15]+times       
		if nt=="T":
                	T_col[length-15]=T_col[length-15]+1
                	T_unc[length-15]=T_unc[length-15]+times

file.close()


#write collapsed table
string=""
outfile=open(id+".firstntab_col.csv","w")
for i in [A_col,C_col,G_col,T_col]:
        for j in i:
                string=string+(str(j)+"\t")
        string=string.rstrip("\t")
        string=string+"\n"
outfile.write(string)
outfile.close()

#write uncollapsed table
string=""
outfil=open(id+".firstntab_unc.csv","w")
for i in [A_unc,C_unc,G_unc,T_unc]:
        for j in i:
                string=string+(str(j)+"\t")
        string=string.rstrip("\t")
        string=string+"\n"
outfil.write(string)
outfil.close()


string=""
for i in [A_col,C_col,G_col,T_col]:
        for j in i:
                string=string+(str(j)+"\t")
        string=string.rstrip("\t")
        string=string+"\n"
print string
