class hpcsoft
{
	   file { "/etc/apt/source.list.d/lucid-universe.list":
				source => "puppet:///utils/apt-get-fixes/lucid-universe.list",
	   }
	   exec { "aptupdate":
        command => "apt-get update",      
        path    => "/usr/local/bin/:/bin/:/sbin",
    	}
	   
	   
	   	
	   package { "gcc": ensure => installed }
	   package { "g++": ensure => installed }
	   
	   package { "openmpi-bin":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }
		
	   package { "openmpi-doc":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }	    
		
	   package { "libopenmpi-dev":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }
}