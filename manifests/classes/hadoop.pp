class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	
	package { "openjdk-7-jre": ensure => installed }
		
	   
}
