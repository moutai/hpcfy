import os
import subprocess

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
	print "scp -i "+ permfilepath+" computehosts root@"+line[0]+":/etc/puppet/utils"	
	p=subprocess.Popen("scp -i "+ permfilepath+" computehosts root@"+line[0]+":/etc/puppet/utils", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	for line1 in p.stdout.readlines():
		print line1

	print "scp -i "+ permfilepath+" ../puppet.conf root@"+line[0]+":/etc/puppet/"
        p=subprocess.Popen("scp -i "+ permfilepath+" ../puppet.conf root@"+line[0]+":/etc/puppet/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        for line1 in p.stdout.readlines():
                print line1	

	if (line[1]=='clusternode0'):	
		print "service puppetmaster restart"	
		p=subprocess.Popen("ssh -i "+ permfilepath+" root@"+line[0]+" 'rm -r /var/lib/puppet/*;/etc/init.d/puppetmaster restart; puppet cert list --all'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
                	print line1
		#raw_input('press enter to continue')
        else:   
		print"service puppet restart"	
		p=subprocess.Popen("ssh -i "+ permfilepath+" root@"+line[0]+" 'rm -r /var/lib/puppet/*; /etc/init.d/puppet restart;ls /var/lib/puppet;puppet agent --test --noop --verbose'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
                	print line1
f.close()


