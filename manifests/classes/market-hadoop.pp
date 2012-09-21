
class market-hadoop
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 

###install apt-fixes
	file { "/etc/apt/sources.list.d/lucid-ppas.list":
                                source => "puppet:///utils/apt-get-fixes/lucid-ppas.list",
                                notify => Exec["aptupdate"],
	}

	exec { "copymarkethadoop":
                command => "rm -rf /usr/local/hadoop; mkdir /usr/local/hadoop; cd /usr/local/hadoop/; git init; git fetch https://github.com/moutai/hadoop-common.git  branch-1.1:refs/remotes/origin/branch-1.1; git checkout --track origin/branch-1.1; ant compile-core compile-mapred examples; chown -R hpcuser:hpcuser /usr/local/hadoop", 
		creates => "/usr/local/hadoop/build",
        }

	


######################################
# Config files
# hadoop_env.sh 
	file { "/usr/local/hadoop/conf/hadoop-env.sh":
                                source => "puppet:///utils/fileserver-files/hadoop_conf/hadoop-env.sh",
				require => Exec["copymarkethadoop"],
	}
# slaves 
	file { "/usr/local/hadoop/conf/slaves":
                                source => "puppet:///utils/fileserver-files/hadoop_conf/slaves",
				require => Exec["copymarkethadoop"],
	}
# master always clusternode0
	file { "/usr/local/hadoop/conf/masters":
                                source => "puppet:///utils/fileserver-files/hadoop_conf/masters",
				require => Exec["copymarkethadoop"],
	}



###install the java openjdk and other tools

	package { "openjdk-6-jdk": 
			ensure => installed,
			require => Package["ant","autoconf","libtool"], 
		}
	package { "ant": ensure => installed }
	package { "autoconf": ensure => installed }
	package { "libtool": ensure => installed }

##add the directory for testing
	file { ["/app"]:
		ensure => directory,
		owner=> hpcuser,
        	group => hpcuser,
	}

	file { ["/app/hadoop"]:
		ensure => directory,
		owner=> hpcuser,
        	group => hpcuser,
		require => File["/app"], 
	}


	file { ["/app/hadoop/tmp"]:
		ensure => directory,
		owner=> hpcuser,
        	group => hpcuser,
		require => File["/app/hadoop"], 
	}

	file { "/etc/security/limits.conf":
                                source => "puppet:///utils/fileserver-files/hadoop_conf/tunings/limits.conf",
                                owner=> root,
                                group => root,
        }

	file { "/etc/pam.d/common-session":
                                source => "puppet:///utils/fileserver-files/hadoop_conf/tunings/common-session",
                                owner=> root,
                                group => root,
        }

 
}



















