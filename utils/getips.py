import os
import sys
import subprocess

f = open('hosts', 'w')
fmpi = open('computehosts', 'w')


if len(sys.argv) > 1 and sys.argv[1]== "aws" :
	print ('This is the VMs under this aws account')
	p = subprocess.Popen("euca-describe-instances |grep running|awk -F\" \" \'{print $4}\'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
       	number_of_hosts=0
        for line in p.stdout.readlines():
		print line
                ip=line.strip().rstrip()
                pair= ip+" clusternode"+str(number_of_hosts)
                print pair
                f.write(pair+"\n")
                fmpi.write("clusternode"+str(number_of_hosts)+"\n")
                number_of_hosts=number_of_hosts+1



else :
	# get the ips of the current machines using the euca tools
	print ('This is the virtual intances that are under this account')
	p = subprocess.Popen("euca-describe-instances |grep running | awk -F\" \" \'{print $4}\'| grep 10| sort", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	number_of_hosts=0
	for line in p.stdout.readlines():
		ip=line.strip().rstrip()
		pair= ip+" clusternode"+str(number_of_hosts)
		print pair
		f.write(pair+"\n")
		fmpi.write("clusternode"+str(number_of_hosts)+"\n")
		number_of_hosts=number_of_hosts+1


f.close()
fmpi.close()




#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt
