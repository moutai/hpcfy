import os
import subprocess
import fileinput

f = open('hosts', 'r')
line=f.readline()
ip=line.strip().rstrip()
line=line.split()


if line[1]=="clusternode0":	
	print line
	for line1 in fileinput.input("Rakefile",inplace=0):
		print line1	
		#lineR=lineR.strip()
		#if lineR.startswith("PUPPETMASTER"):
	#		print "PUPPETMASTER='%s'" % line[0]
	#	else:
	#		print lineR	

f.close()
