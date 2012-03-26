class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	
	package { "openjdk-6-jdk": ensure => installed }
		
	   
}
