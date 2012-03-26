class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	
	package { "openjdk-6-jdk": ensure => installed }

	


	file { "/opt/hadoop-debs":
		ensure => directory
		notify => Exec["getHadoop"],
	}

# Currently using the deb to install hadoop 
#http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-1.0.1/hadoop_1.0.1-1_amd64.deb


	exec { "getHadoop":
  		provider => shell,
		cwd =>"/opt/hadoop-debs",
		command => "wget http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-1.0.1/hadoop_1.0.1-1_amd64.deb",
		creates => "/opt/hadoop-debs/hadoop_1.0.1-1_amd64.deb",
		logoutput => "on_failure",
	}

	

   	#package { "hadoop":
     	#	provider => dpkg,
    	#	ensure => installed,
    	#	source => "/opt/hadoop-debs/hadoop_1.0.1-1_amd64.deb"
	#}
		
	   
}
