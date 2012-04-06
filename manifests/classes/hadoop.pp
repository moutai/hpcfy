
class hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 



###install the sun java 7 

	file { "/etc/apt/sources.list.d/lucid-ppas.list":
                                source => "puppet:///utils/apt-get-fixes/lucid-ppas.list",
                                notify => Exec["aptupdate","installsunjava"],
	}

	exec { "installsunjava":
                command => "apt-get --force-yes -y install oracle-java7-installer",
		require => File["/etc/apt/sources.list.d/lucid-ppas.list"],                
        }

###remove the openjdk

	package { "openjdk-6-jdk": ensure => purged }



####add the cloudera repositories.

	file { "/etc/apt/sources.list.d/cloudera.list":
                                source => "puppet:///utils/apt-get-fixes/cloudera.list",
                                notify => Exec["aptupdate","installclouderakey"],
        }

	exec { "installclouderakey":
                command => "curl -s http://archive.cloudera.com/debian/archive.key | sudo apt-key add -",
                require => File["/etc/apt/sources.list.d/cloudera.list"],
		refreshonly => true, 
        }
	
#####add the hadoop package


        package { "hadoop":
               ensure => installed,
               require => [Exec["installsunjava"],File["/etc/apt/sources.list.d/cloudera.list"]]
        }

	package {["hadoop-0.20-namenode","hadoop-0.20-datanode","hadoop-0.20-secondarynamenode","hadoop-0.20-jobtracker","hadoop-0.20-tasktracker"]:
               ensure => installed,
               require => [Exec["installsunjava"],File["/etc/apt/sources.list.d/cloudera.list"]]
       }


######################################
# Config files
	file { "/etc/hadoop-0.20/conf":
		ensure => directory, # so make this a directory
		recurse => true, # enable recursive directory management
		purge => true,# purge all unmanaged junk
  		force => true, # also purge subdirs and links etc.
  		owner => "root",
  		group => "root",
  		#mode => 0644, # this mode will also apply to files from the source directory
  		# puppet will automatically set +x for directories
  		source => "puppet:///utils/fileserver-files/hadoop_conf",
	}



	file { "/hadoop_data":
		ensure => directory,
		owner=> root,
        	group => root,
		require => Package["hadoop"],
	}

	file { "/hadoop_data/name":
                ensure => directory,
                owner=> hdfs,
                group => hadoop,
                require => Package["hadoop"],
        }
	
	file { "/hadoop_data/data":
                ensure => directory,
                owner=> hdfs,
                group => hadoop,
                require => Package["hadoop"],
        }

	file { "/hadoop_data/mapred":
                ensure => directory,
                owner=> mapred,
                group => hadoop,
                require => Package["hadoop"],
        }







	
	
			  
}



















