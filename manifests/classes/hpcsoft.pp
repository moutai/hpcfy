class hpcsoft
{
	   package { "gcc": ensure => installed }
	   package { "g++": ensure => installed }
	   
	   package { "openmpi-bin":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"]]
	   }
		
	   package { "openmpi-doc":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"]]
	   }	    
		
	   package { "libopenmpi-dev":
	   	ensure => installed,
	   	require => [Package["gcc"],Package["g++"]]
	   }
}