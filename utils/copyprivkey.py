import os
import subprocess
homedir = os.path.expanduser('~')

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "scp "+homedir+"/.ssh/id_rsa root@"+line[0]+":~/.ssh/"	
	p=subprocess.Popen("scp "+homedir+"/.ssh/id_rsa root@"+line[0]+":~/.ssh/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
                print line1

	#break
f.close()


