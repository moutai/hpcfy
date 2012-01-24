import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "scp ~/.ssh/.ssh/id_rsa root@"+line[0]+":~/.ssh/"	
	p=subprocess.Popen("scp ~/.ssh/.ssh/id_rsa root@"+line[0]+":~/.ssh/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	break
f.close()


