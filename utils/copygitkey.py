import os
import subprocess
import sys


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
	if len(sys.argv)>1 and sys.argv[1]=="aws":
		print "scp -i "+ permfilepath+" ~/.ssh/id_rsa root@"+line[0]+":~/.ssh/"	
		p=subprocess.Popen("scp -i "+ permfilepath+" ~/.ssh/id_rsa root@"+line[0]+":~/.ssh/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	else:
		print "scp ~/.ssh/id_rsa root@"+line[0]+":~/.ssh/"	
		p=subprocess.Popen("scp ~/.ssh/id_rsa root@"+line[0]+":~/.ssh/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

	for line1 in p.stdout.readlines():
       	        print line1

	break
f.close()














