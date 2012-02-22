class nasbenchsoft
{
	   Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
	   
	   
	   file { "/home/hpcuser/NPB3.3.1.tar.gz":
				source => "puppet:///utils/fileserver-files/NPB3.3.1.tar.gz",
				notify => Exec["unpackNPB"],
				require => User["hpcuser"],
				owner=> hpcuser,
        		group => hpcuser,
	   }
	   
	   
	   exec { "unpackNPB":
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
