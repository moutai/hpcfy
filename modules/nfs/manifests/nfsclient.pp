class nfsclient
{
	    package { "nfs-common": ensure => installed }
	
		service { "nfs-common":
		ensure => running,
		enable => true,
		hasrestart => true, 
		require => Package["nfs-common"],
		}
		    
		exec { "mount-home":
		command => "mount clusternode0:/data /home",
		refreshonly => true,
		}
}