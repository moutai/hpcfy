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
	   	cwd => "/home/hpcuser",
        command => "su hpcuser tar xzf NPB3.3.1.tar.gz",  
        require => File["/home/hpcuser/NPB3.3.1.tar.gz"],
        creates => "NPB3.3.1", 
    	}	
    	
    		
    	
}
