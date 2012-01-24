import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	if line[1]=="clusternode0":
		print "ssh root@"+line[0]+" apt-get install puppetmaster "
	else:
		print "ssh root@"+line[0]+" apt-get install puppet "

	
#	p=subprocess.Popen("cat hosts | ssh root@"+line[0]+" \"cat>>/etc/hosts\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#	print p

f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
