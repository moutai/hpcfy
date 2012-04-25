import os
import subprocess
import sys
f = open('hosts', 'r')

infofile= open('instances-info')
infolines = infofile.readlines()
infofile.close()

print infolines[3]
permfile = infolines[3].strip().rstrip()
permfilepath="~/.hpcfy/"+permfile+".pem"

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	if len(sys.argv)>1 and sys.argv[1]=="aws":
		print "cat hosts | ssh -i "+ permfilepath+" root@"+line[0]+" \"cat>>/etc/hosts\""
		p=subprocess.Popen("cat hosts | ssh -i "+ permfilepath+" root@"+line[0]+" \"cat>>/etc/hosts\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

	else:
		print "cat hosts | ssh root@"+line[0]+" \"cat>>/etc/hosts\""
		p=subprocess.Popen("cat hosts | ssh root@"+line[0]+" \"cat>>/etc/hosts\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

	for line1 in p.stdout.readlines():
        	print line1

f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
