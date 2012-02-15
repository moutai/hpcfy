class user::virtual
{
	@user { "hpcuser": 
		ensure => "present",
		uid => "5001",
		gid =>"5001",
		comment =>"hpc user",
		home => "/home/hpcuser",
		shell => "bin/bash",
	}
	@user { "ladmin": 
		ensure => "present",
		uid => "5002",
		gid =>"5002",
		comment =>"admin",
		home => "/home/admin",
		shell => "bin/bash",
	}
	
}