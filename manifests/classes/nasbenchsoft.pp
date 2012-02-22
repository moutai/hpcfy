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
        command => "cd /home/hpcuser; tar xzvf /home/hpcuser/NPB3.3.1.tar.gz; chmod -R hpcuser:hpcuser /home/hpcuser/NPB3.3.1;",  
        require => File["/home/hpcuser/NPB3.3.1.tar.gz"],
        creates => "/home/hpcuser/NPB3.3.1", 
	   }	
    	
    	
}
