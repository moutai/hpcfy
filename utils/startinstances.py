import os
import subprocess
import time
import string
import time

def waitforinstances(emi):
    while True:
        print "euca-describe-instances | grep "+emi+" |grep pending"   
        p=subprocess.Popen("euca-describe-instances| grep pending ", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        numlines=0
        for line in p.stdout.readlines():
            print line
            numlines=numlines+1
        if numlines>0:
            time.sleep(3)
        else :
            print 'starting instances done'
            return 
        
def main():
    f = open('instances-info', 'r')
    #start = time.time()
    emi=f.readline()
    emi=string.rstrip(emi)
    print 'emi used:'+emi

	
    num=f.readline()
    num= string.rstrip(num)
    print 'number of instances: '+num

    vmtype=f.readline()
    vmtype= string.rstrip(vmtype)
    print 'instance type: '+vmtype
    
    keypair=f.readline()
    keypair= string.rstrip(keypair)
    print 'instance type: ' + keypair
    
    if keypair!='':
	print "euca-run-instances -n "+num+" -t "+vmtype+" -k "+ keypair+" "+ emi 

    else :
    	print "euca-run-instances -n "+num+" -t "+vmtype+" "+ emi

    #elapsed =time.time()-start
    #print "start up time for euca-run-instances -n "+num+" -t "+vmtype+" "+ emi+":\n"+ str(elapsed)

    confirmation=raw_input ('Please confirm your action Y/N:')
    print confirmation
    
    if (confirmation=='Y'):
 	start = time.time()	
	if keypair=='':
	        print "euca-run-instances -n "+num+" -t "+vmtype+" "+ emi
	        p=subprocess.Popen("euca-run-instances -n "+num+" -t "+vmtype+" "+ emi , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	else: 
		print "euca-run-instances -n "+num+" -t "+vmtype+" -k "+ keypair+" "+ emi
		p=subprocess.Popen("euca-run-instances -n "+num+" -t "+vmtype+" -k "+ keypair+" "+ emi, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        
	for line in p.stdout.readlines():
            print line
        f.close()
        
        waitforinstances(emi)
        elapsed =time.time()-start
	print "start up time for euca-run-instances -n "+num+" -t "+vmtype+" "+ emi+":\n"+ str(elapsed)

    else :
         print "ok bye."
         
         
         
         
         
         
if __name__ == "__main__":
    main()
