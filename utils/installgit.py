import os
import subprocess
f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	#install the git core on the clusternode0 with the -y flag on
	print "ssh root@"+line[0]+" apt-get -y install git-core "
	p=subprocess.Popen("ssh root@"+line[0]+" apt-get -y install git-core ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
		print line1
f.close()
