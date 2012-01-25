import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "scp ../puppet.conf root@"+line[0]+":/etc/puppet/"	
	p=subprocess.Popen("scp ../puppet.conf root@"+line[0]+":/etc/puppet/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
                print line1

	p=subprocess.Popen("ssh root@"+line[0]+" \' service puppetmaster restart; service puppet restart\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
                print line1

f.close()


