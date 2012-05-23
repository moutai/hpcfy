# Hpcfy overview
Author: Moussa Taifi

This is a puppet project to create an mpi or hadoop-ready cluster out of virtual machines. The utilities are geared more specifically towards using an eucalyptus private cloud account. The puppet part of this project can be used for any virtual machine, be it private or public cloud. It provide basic capabilities for creating a shared nfs filesystem, user home directories, password-less key setup and basic HPC packages management (gcc, mpi,...).

To see it in action(videos):
https://sites.google.com/a/temple.edu/tcloud/cloud-clusters-hpcfy

##Getting Started:

###Step 0 setting the environment

Clone this project and change to the utils directory. 

Make sure that the euca2ools are working with your eucalyptus credentials.

Change the path 'export HPCFY_PATH=~/hpcfy' in utils/hpcfyrc to the cloned folder.

Run 'source utils/hpcfyrc' to get the hpcfy binary in your path.

###Step 1 
	Select and start instances
	Modify the utils/instance-info file to describe the cluster:
		File content:		
			image-id
			number of clusternodes
			type of clusternodes
			permission file/keypair.private
	Start the cluster:
		hpcfy startcluster

###Step 2 
	Initialize the cluster:
		hpcfy initialize

###Step 3 
	Apply the configuration:
		hpcfy applyconfig

###Step 4
	Login to the master node:
		hpcfy logintomaster

###Step 5 
	Cluster monitoring is located at
		http://master-ip/ganglia




###Hadoop/Mahout considerations

To start a local hadoop cluster this is the steps to follow:

	hpcfy logintomaster
	su hpcuser
	hadoop namenode -format
	start-all.sh

This should start a hadoop cluster composed of all your nodes. 

	Hadoop monitoring is located at:
		http://master-ip:50070/dfshealth.jsp
		http://master-ip:50030/jobtracker.jsp
		http://master-ip:50060/tasktracker.jsp

For running Mahout, the current Mahout version from the cloudera distribution is available and is accessible using 

mahout jar yourjar name-of-run



	
	
###More detailed documentation for dev:


*Step 1 Initialization

	start the instances
		python startinstances.py
	wait for instances to start
		wait......:)
	get the ips
		python getips.py
	add the current public key to all the nodes
		python addpubkeytonodes.py
	add the current private key to all the nodes
		python copyprivkey.py
	set the hostnames
		python sethostnames.py
	send the hosts file
		python sendhostsfile.py
	install puppetmaster on master and puppet on puppet clients
		python installpuppet.py
	install git to the headnode
		python installgit.py

Step 2 Initial puppet configuration

	set the rakefile
		python setrakefile.py
	deploy initial config to clusternode0
		rake cleandeploy or rake cleandeploydevelop
	copy puppet conf to all the nodes and restart services
		python copypuppetconf.py
	sign the certificates of the nodes
		python signcerts.py
	
Step 3 apply the configuration to all the nodes

	trigger apply to all nodes 
		python triggerapplyall.py		

Step 4 access the headnode
	
	logging to your headnode
		sh logintomaster.sh

Step 5-development: customizing the beowulf cluster

	add the necessary hpc software needed for the deployment under hpcfy/manifests/classes/hpcsoft.pp

	save and commit your changes

	copy local changes to the virtual cluster headnode (prefered way is to copy just the changes)
		TODO using git to update the latest version of the puppet changes 	
		scp -r ~/hpcfy/* root@ip-of-virtual-cluster-headnode:/etc/puppet/ root@ip-of-virtual-cluster-headnode

	trigger apply to all nodes 
		python triggerapplyall.py
	



Hadoop/Mahout considerations

To start a local hadoop cluster this is the steps to follow:

cd hpcfy/utils
sh logintomaster.sh
su hpcuser
hadoop namenode -format
start-all.sh

This should start a hadoop cluster composed of all your nodes. 

For running Mahout, the current Mahout version from the cloudera distribution is available and is accessible using 

mahout jar yourjar name-of-run




















