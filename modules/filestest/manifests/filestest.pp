class  filestest{
	
	file { "/etc/puppet/utils":
    ensure => "directory",
    owner  => "puppet",
    group  => "puppet",
    mode   => 750,
	}
	
	file { "/etc/puppet/utils/fileserver-files":
    ensure => "directory",
    owner  => "puppet",
    group  => "puppet",
    mode   => 750,
	}
	
	file { "/etc/puppet/utils/fileserver-files/fileserver-test-output.txt":
	source => "puppet:///utils/fileserver-files/fileserver-test.txt",
	}
 
}
