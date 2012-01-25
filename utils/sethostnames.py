import os
import subprocess

f = open('hosts', 'r')
for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "ssh root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'"
	p=subprocess.Popen("ssh root@"+line[0]+" \'echo \""+line[1]+"\" /etc/hostname ; hostname "+line[1]+"\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line in p.stdout.readlines():
		print line
f.close()
