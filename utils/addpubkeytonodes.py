import os
import subprocess
import pexpect
import getpass 
import sys
import os.path
from M2Crypto import RSA
import shutil
homedir = os.path.expanduser('~')

def checkkeys():
	priv=homedir+"/.ssh/id_rsa"
	pub=homedir+"/.ssh/id_rsa.pub"
	if (os.path.isfile(priv)==False or os.path.isfile(pub)==False):
		return False
	else:
		return True

def generatekeys():
	key = RSA.gen_key(1024, 65337)
	key.save_key("id_rsa", cipher=None)
	shutil.move("id_rsa", homedir+"/.ssh/id_rsa")
	os.chmod(homedir+'/.ssh/id_rsa', 0400)

	os.system('ssh-keygen -y -f '+homedir+'/.ssh/id_rsa'+' > '+homedir+'/.ssh/id_rsa.pub' )
	os.system('cat '+homedir+'/.ssh/id_rsa.pub >> '+homedir+'/.ssh/authorized_keys2')

	return True

#check if the public and private keys are generated otherwise generate them
if checkkeys()==False:
	print 'please generate a set of keys to be used for the rest of the deployment'
	print 'Keys needed: ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub'
	keydecision=raw_input("Press Y if you want hpcfy to generate them for you:\n")
	if keydecision=='Y':
		generatekeys()
		
	else:
		print'ok bye'
		sys.exit(0)



ssh_newkey = 'Are you sure you want to continue connecting'

f = open('hosts', 'r')
print 'Adding the public key linked to this account, to all the nodes discovered :'

for line in f.readlines():
	ip=line.strip().rstrip()
	line=line.split()
	print "scp "+homedir+"/.ssh/authorized_keys2 root@"+line[0]+":/root/.ssh/authorized_keys"

	p=pexpect.spawn("scp "+homedir+"/.ssh/authorized_keys2 root@"+line[0]+":/root/.ssh/authorized_keys")
	i=p.expect([ssh_newkey,'password:',pexpect.EOF])
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


	
f.close()
