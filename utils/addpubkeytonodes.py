import os
import subprocess
import pexpect
import getpass 


ssh_newkey = 'Are you sure you want to continue connecting'


f = open('hosts', 'r')
print 'Adding the public key linked to this account, to all the nodes discovered :'

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	#print "cat  ~/.ssh/id_rsa.pub | ssh root@"+line[0]+" \"cat>>~/.ssh/authorized_keys2\""
	print "scp /home/"+getpass.getuser()+"/.ssh/authorized_keys2 root@"+line[0]+":/root/.ssh/authorized_keys"

	p=pexpect.spawn("scp /home/"+getpass.getuser()+"/.ssh/authorized_keys2 root@"+line[0]+":/root/.ssh/authorized_keys")
	i=p.expect([ssh_newkey,'password:',pexpect.EOF])
	print p.before
	if i==0:
	    	print "I say yes"
    		p.sendline('yes')
    		i=p.expect([ssh_newkey,'password:',pexpect.EOF])
	if i==1:
		#temporary fix until we get an image with a public key injected in it. 
    		print "I give password for testing only ",
    		p.sendline("password")
    		p.expect(pexpect.EOF)
	elif i==2:
    		print "I either got key or connection timeout"
    		pass
	print p.before # print out the result
	

#p=subprocess.Popen("cat  ~/.ssh/id_rsa.pub | ssh root@"+line[0]+" \"cat>>~/.ssh/authorized_keys2\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	#for line1 in p.stdout.readlines():
             #   print line1
f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
