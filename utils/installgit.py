import os
import subprocess

f = open('hosts', 'r')
infofile= open('instances-info')
infolines = infofile.readlines()
infofile.close()

print infolines[3]
permfile = infolines[3].strip().rstrip()
permfilepath="~/.hpcfy/"+permfile+".pem"

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	if line[1]=="clusternode0":	
		#install the git core on the clusternode0 with the -y flag on
		print "ssh -i "+ permfilepath+" root@"+line[0]+" apt-get -y install git-core "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" apt-get -y install git-core ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
f.close()
