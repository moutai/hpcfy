import os
import subprocess
import sys

try:
   f=open('instances-info','r')
except IOError as e:
   print 'Please create a file hpcfy/utils/instances-info with your choice of cluster configuration with the following format:'
   print 'image id'
   print 'number of instances'
   print 'Type of instances' 
   print 'Permission file name'
   sys.exit()


print ('Cluster configuration file content: \n')
line = f.readline()
print "Image Id: "+line; 
line = f.readline()
print "Number of instances: "+line;
line = f.readline()
print "Type of instances: "+line;
line = f.readline()
print "Permission file name: "+line;

f.close()

