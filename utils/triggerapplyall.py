import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "rake apply CLIENT="+line[0]
	p=subprocess.Popen("rake apply CLIENT="+line[0], shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#	print p
	for line1 in p.stdout.readlines():
        	print line1

f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
