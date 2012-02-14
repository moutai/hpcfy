node default { 
	#include cluster
	#include filestest
	#include ntp
	include user
	include nfsclient
}
 
 
node "clusternode0" inherits default{
	nfs::share { "data":
	path => "/data",
	allowed => "10.80.160.0/24",
	options => "rw,sync,no_root_squash",
	} 
}