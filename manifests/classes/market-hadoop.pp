
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

	exec { "copymarkethadoop":
                command => "rm -rf /usr/local/hadoop; mkdir /usr/local/hadoop; cd /usr/local/hadoop/; git init; git fetch https://github.com/moutai/hadoop-common.git  branch-1.1:refs/remotes/origin/branch-1.1; git checkout --track origin/branch-1.1",
		require => Exec["installsunjava"], 
        }

###remove the openjdk

	package { "openjdk-6-jdk": ensure => purged }

##add the directory for testing

	file { ["/app/hadoop/tmp"]:
		ensure => directory,
		owner=> hpcuser,
        	group => hpcuser,
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



















