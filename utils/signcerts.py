import os
import subprocess
f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	if line[1]=="clusternode0":	
		headnode=line[0]
		
	#sign the certificates
	print "ssh root@"+headnode+" puppet cert sign --all"
	#raw_input()
	p=subprocess.Popen("ssh root@"+headnode+" puppet cert sign --all ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
		print line1
	break
f.close()



