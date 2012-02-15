class user::virtual
{
	file { "/home/hpcuser":
    ensure => "directory",
    owner  => "hpcuser",
    group  => "developers",
    mode   => 750,
	}
	@user { "hpcuser": 
		require => File["/home/hpcuser"],
		ensure => "present",
		uid => "5001",
		gid =>"5001",
		comment =>"hpc user",
		home => "/home/hpcuser",
		shell => "/bin/bash",
		managehome => true
	}
	
	
	@user { "ladmin": 
		ensure => "present",
		uid => "5002",
		gid =>"5002",
		comment =>"admin",
		home => "/home/admin",
		shell => "/bin/bash",
		managehome => true
	}
	
	@group { "sysadmins":
		gid => "5002",
		ensure => present,
	}
	
	@group { "developers":
		gid => "5001",
		ensure => present,
	}
	
	
}