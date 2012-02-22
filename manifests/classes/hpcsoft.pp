class hpcsoft
{
	   Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
	   
	   
	   file { "/etc/apt/sources.list.d/lucid-universe.list":
				source => "puppet:///utils/apt-get-fixes/lucid-universe.list",
				notify => Exec["aptupdate"],
	   }
	   
	   
	   exec { "aptupdate":
        command => "apt-get update",  
        refreshonly => true,    
    	}	
	   
	   	
	   package { "gcc": ensure => installed }
	   package { "g++": ensure => installed }
	   package { "vim": ensure => installed }
	   package { "wget": ensure => installed }
	   
	   package { "locate": ensure => installed }
	   package { "gfortran": ensure => installed }
	   
	   package { "openmpi-bin":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/sources.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }
		
	   package { "openmpi-doc":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/sources.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }	    
		
	   package { "libopenmpi-dev":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/sources.list.d/lucid-universe.list"],Exec["aptupdate"]],
	   }
}
