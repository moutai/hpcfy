import os
import subprocess

f = open('hosts', 'w')
# get the ips of the current machines using the euca tools
p = subprocess.Popen("euca-describe-instances | awk -F\" \" \'{print $4}\'| grep 10| sort", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
number_of_hosts=0
for line in p.stdout.readlines():
	ip=line.strip().rstrip()
	pair= ip+" clusternode"+str(number_of_hosts)
	f.write(pair+"\n")
	number_of_hosts=number_of_hosts+1
f.close()


#euca-describe-instances | awk -F" " '{print $4}'| grep 10| sort > ips.txt
#cat ips.txt