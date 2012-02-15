node default { 
	#include cluster
	#include filestest
	#include ntp
	
	include nfs::client
	#include user::virtual
	#include user::sysadmins
	#include user::developers
}
 
 
node "clusternode0" inherits default{
	nfs::server::share { "data":
	path => "/data",
	allowed => "10.80.160.0/24",
	options => "rw,sync,no_root_squash",
	} 
}