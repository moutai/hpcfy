class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 
	package { "openjdk-6-jdk": ensure => installed }

	file { "/opt/hadoop-debs":
		ensure => directory,
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
   	package { "hadoop":
     		provider => dpkg,
    		ensure => installed,
    		source => "/opt/hadoop-debs/hadoop_1.0.1-1_amd64.deb"
	}

# Config files
	file { "/etc/hadoop/hadoop-env.sh":
				source => "puppet:///utils/fileserver-files/hadoop_conf/hadoop-env.sh",
				owner=> root,
        			group => root,
				require => Package["hadoop"],
	}
	

	file { "/etc/hadoop/core-site.xml":
				source => "puppet:///utils/fileserver-files/hadoop_conf/core-site.xml",
				owner=> root,
        			group => root,
				require => Package["hadoop"],
	}

	file { "/etc/hadoop/mapred-site.xml":
				source => "puppet:///utils/fileserver-files/hadoop_conf/mapred-site.xml",
				owner=> root,
        			group => root,
				require => Package["hadoop"],
	}
	

	file { ["/hadoop_data","/hadoop_data/tmp","/var/log/hadoop","/var/run/hadoop"]:
		ensure => directory,
		owner=> hpcuser,
        	group => hpcuser,
		require => Package["hadoop"],
	}
	
	#file { "/hadoop_data/tmp":
	#	ensure => directory,
	#}

	
			  
}



















