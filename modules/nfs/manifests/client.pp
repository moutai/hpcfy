class nfs::client
{
	   package { "nfs-common": ensure => installed }
	
		#service { "nfs-common":
		#ensure => running,
		#enable => true,
		#hasrestart => true, 
		#require => Package["nfs-common"],
		#}
		    
		mount { "/home":
        device  => "clusternode0:/data",
        fstype  => "nfs",
        ensure  => "mounted",
        options => "defaults",
        atboot  => true,
    	}
}