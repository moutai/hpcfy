import os
import subprocess
import time

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
    print 'emi used:'+emi
    
    num=f.readline()
    print 'number of instances: '+num
    
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