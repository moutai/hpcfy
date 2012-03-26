class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	
	package { "sun-java6-jdk": ensure => installed }
		
	   
}
