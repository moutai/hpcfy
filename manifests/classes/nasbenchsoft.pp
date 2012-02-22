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
        command => "su hpcuser tar xvzf /home/hpcuserNPB3.3.1.tar.gz",  
        refreshonly => true,    
    	}	
    	
}
