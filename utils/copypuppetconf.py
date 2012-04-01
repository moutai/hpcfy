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


	if (line[1]=='clusternode0'):	
		print "service puppetmaster restart"	
		p=subprocess.Popen("ssh root@"+line[0]+" 'rm -r /var/lib/puppet/*;/etc/init.d/puppetmaster restart; puppet cert list --all'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
                	print line1
		#raw_input('press enter to continue')
        else:   
		print"service puppet restart"	
		p=subprocess.Popen("ssh root@"+line[0]+" 'rm -r /var/lib/puppet/*; /etc/init.d/puppet restart;ls /var/lib/puppet;puppet agent --test --noop --verbose'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
                	print line1
f.close()


