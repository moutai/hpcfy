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
	if line[1]=="clusternode0":	
		#add the lucid backport
		print "scp -i "+ permfilepath+" apt-get-fixes/lucid-backport.list  root@"+line[0]+":/etc/apt/sources.list.d/"
		p=subprocess.Popen("scp  -i "+ permfilepath+" apt-get-fixes/lucid-backport.list  root@"+line[0]+":/etc/apt/sources.list.d/", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		
		#do one apt get update		
		print "ssh -i "+ permfilepath+"  root@"+line[0]+" apt-get update "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" apt-get update ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		#install the puppetmaster with the -y flag on
		print "ssh -i "+ permfilepath+" root@"+line[0]+" apt-get -y install puppetmaster "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" apt-get -y install puppetmaster ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		#change the ownership of the folder var/lib/puppet
		print "ssh -i "+ permfilepath+" root@"+line[0]+" chown puppet:puppet /var/lib/puppet "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" chown puppet:puppet /var/lib/puppet ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')	
	else:
		
		#add the lucid backport
		print "scp -i "+ permfilepath+" apt-get-fixes/lucid-backport.list  root@"+line[0]+":/etc/apt/sources.list.d/"
		p=subprocess.Popen("scp  -i "+ permfilepath+" apt-get-fixes/lucid-backport.list  root@"+line[0]+":/etc/apt/sources.list.d/lucid-backport.list", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		#do one update		
		print "ssh -i "+ permfilepath+" root@"+line[0]+" apt-get update "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" apt-get update ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		#install the puppet client
		print "ssh -i "+ permfilepath+" root@"+line[0]+" apt-get -y install puppet "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" apt-get -y install puppet ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')
		#change the puppet folder
		print "ssh -i "+ permfilepath+" root@"+line[0]+" chown puppet:puppet /var/lib/puppet "
		p=subprocess.Popen("ssh  -i "+ permfilepath+" root@"+line[0]+" chown puppet:puppet /var/lib/puppet ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')	
		#add the var/lib/puppet file
		print "scp -i "+ permfilepath+" apt-get-fixes/puppet  root@"+line[0]+":/etc/default/puppet"
		p=subprocess.Popen("scp  -i "+ permfilepath+" apt-get-fixes/puppet  root@"+line[0]+":/etc/default/puppet", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		for line1 in p.stdout.readlines():
			print line1
		#raw_input('press enter to continue')	
			
#	p=subprocess.Popen("cat hosts | ssh root@"+line[0]+" \"cat>>/etc/hosts\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#	print p
f.close()
#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
