import os
import subprocess

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
else :
     print "ok bye."