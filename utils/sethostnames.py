import os
import subprocess
import sys
print 'Setting the hostnames for the clusternodes'
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
		print "ssh -i "+ permfilepath+" root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'"
		p=subprocess.Popen("ssh -i "+ permfilepath+" root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	else:
		print "ssh root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'"
		p=subprocess.Popen("ssh root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

	for line in p.stdout.readlines():
		print line
f.close()
