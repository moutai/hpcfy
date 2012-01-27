import os
import subprocess

f = open('hosts', 'r')

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "ssh root@"+line[0]+" \'find /var/lib/puppet -type f -print0 |xargs -0r rm\'"
	p=subprocess.Popen("ssh root@"+line[0]+" \'find /var/lib/puppet -type f -print0 |xargs -0r rm\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#	print p
	for line1 in p.stdout.readlines():
        	print line1

f.close()




f = open('hosts', 'r')

for line in f.readlines():
        ip=line.strip().rstrip()
        line=line.split()
        print "ssh root@"+line[0]+" puppet cert clean --all"
        p=subprocess.Popen("ssh root@"+line[0]+" puppet cert clean --all", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#       print p
        for line1 in p.stdout.readlines():
                print line1
	break
f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
