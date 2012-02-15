class user::virtual
{
	file { "/home/hpcuser":
    ensure => "directory",
    owner  => "hpcuser",
    group  => "developers",
    mode   => 750,
	}
	@user { "hpcuser": 
		notify => File["/home/hpcuser"],
		ensure => "present",
		uid => "5001",
		gid =>"5001",
		comment =>"hpc user",
		home => "/home/hpcuser",
		shell => "/bin/bash",
		managehome => true
	}
	
	#exec { "fix the ssh keys for password less internode access":
	#command => "ssh-keygen -t dsa -P '' -f /home/hpcuser/.ssh/id_dsa; cat /home/hpcuser/.ssh/id_dsa.pub >> /home/hpcuser/.ssh/authorized_keys",
	#require => File["/home/hpcuser"],
	#refreshonly => true,
	#}
	
	
	
	file { "/home/ladmin":
    ensure => "directory",
    owner  => "ladmin",
    group  => "sysadmins",
    mode   => 750,
	}
	@user { "ladmin": 
		require => File["/home/ladmin"],
		ensure => "present",
		uid => "5002",
		gid =>"5002",
		comment =>"admin",
		home => "/home/ladmin",
		shell => "/bin/bash",
		managehome => true
	}
	#exec { "fix the ssh keys for password less internode access":
	#command => "ssh-keygen -t dsa -P '' -f /home/ladmin/.ssh/id_dsa; cat /home/ladmin/.ssh/id_dsa.pub >>/home/ladmin/.ssh/authorized_keys",
	#require => File["/home/ladmin"],
	#refreshonly => true,
	#}
	
	
	
	@group { "sysadmins":
		gid => "5002",
		ensure => present,
	}
	
	@group { "developers":
		gid => "5001",
		ensure => present,
	}
	
	
}