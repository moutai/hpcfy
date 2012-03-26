class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	
	package { "openjdk-6-jdk": ensure => installed }

	file { "/opt/hadoop-debs":
		ensure => directory
	}

# Currently using the deb to install hadoop 
#http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-1.0.1/hadoop_1.0.1-1_amd64.deb

	file { "/opt/hadoop-debs/hadoop_1.0.1-1_amd64.deb":
	    	owner   => root,
	   	group   => root,
	   	mode    => 644,
	    	ensure  => present,
	    	source  => "http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-1.0.1/hadoop_1.0.1-1_amd64.deb"
	}

   	package { "hadoop":
     		provider => dpkg,
    		ensure => installed,
    		source => "/opt/hadoop-debs/hadoop_1.0.1-1_amd64.deb"
	}
		
	   
}
