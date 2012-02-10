class  filestest{
	
	file { "/etc/puppet/utils/fileserver-files/fileserver-test-output.txt":
	source => "puppet:///utils/fileserver-files/fileserver-test.txt",
	}
 
}
