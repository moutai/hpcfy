import os
import subprocess
import time
import string


def waitforinstances():
    while True:
        print "euca-describe-instances |grep pending"   
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
    
    emi=f.readline()
    emi=string.rstrip(emi)
    print 'emi used:'+emi

    num=f.readline()
    num= string.rstrip(num)
    print 'number of instances: '+num
    
    print "euca-run-instances -n "+num+" -t c1.xlarge " + emi    
    confirmation=raw_input ('Please confirm your action Y/N:')
    print confirmation
    
    if (confirmation=='Y'):
	
        print "euca-run-instances -n "+num+" -t c1.xlarge " + emi    
        p=subprocess.Popen("euca-run-instances -n "+num+" -t c1.xlarge " + emi , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        for line in p.stdout.readlines():
            print line
        f.close()
        
        waitforinstances()
        
    else :
         print "ok bye."
         
         
         
         
         
         
if __name__ == "__main__":
    main()
