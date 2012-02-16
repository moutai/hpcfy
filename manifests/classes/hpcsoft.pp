class hpcsoft
{
	   file { "/etc/apt/sources.list.d/lucid-universe.list":
				source => "puppet:///utils/apt-get-fixes/lucid-universe.list",
	   }
	   	
#	   package { "gcc": ensure => installed }
#	   package { "g++": ensure => installed }
#	   
#	   package { "openmpi-bin":
#	   	ensure => installed,
#	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
#	   }
#		
#	   package { "openmpi-doc":
#	   	ensure => installed,
#	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
#	   }	    
#		
#	   package { "libopenmpi-dev":
#	   	ensure => installed,
#	   	require => [Package["gcc"],Package["g++"],File["/etc/apt/source.list.d/lucid-universe.list"],Exec["aptupdate"]],
#	   }
}