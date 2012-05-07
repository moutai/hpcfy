import os
import subprocess
import fileinput

hostfile = open('hosts', 'r')
infofile= open('instances-info')
rakefile= open('Rakefile.template','r')
newrakefile= open('Rakefile','w')


infolines = infofile.readlines()
infofile.close()
print infolines[3]
permfile = infolines[3].strip().rstrip()
permfilepath="~/.hpcfy/"+permfile+".pem"

line=hostfile.readline()
ip=line.strip().rstrip()
line=line.split()
ip= line[0]
print ip
print permfilepath


for oldline in rakefile.readlines():
	if oldline.find("PUPPETMASTER =")!=-1: 
		print oldline
		oldline="PUPPETMASTER ='"+str(ip)+"'\n"
		print oldline

	if oldline.find("PERMFILE =")!=-1: 
		print oldline
		oldline="PERMFILE ='"+str(permfilepath)+"'\n"
		print oldline
	
	newrakefile.write(oldline)
	



hostfile.close()
infofile.close()
rakefile.close()
newrakefile.close()











