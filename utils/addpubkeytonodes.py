import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "cat  ~/.ssh/id_rsa.pub | ssh root@"+line[0]+" \"cat>>~/.ssh/authorized_keys2\""
	p=subprocess.Popen("cat  ~/.ssh/id_rsa.pub | ssh root@"+line[0]+" \"cat>>~/.ssh/authorized_keys2\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
                print line1
f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt