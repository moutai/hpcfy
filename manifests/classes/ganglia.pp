class ganglia-client
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] } 	
	package { "ganglia-monitor": ensure => installed }
#config files
#/etc/puppet/utils/fileserver-files/ganglia_conf/
#/etc/puppet/utils/fileserver-files/ganglia_conf/
#gmetad.conf  gmond.conf

	file { "/etc/ganglia/gmond.conf":
				source => "puppet:///utils/fileserver-files/ganglia_conf/gmond.conf",
				owner=> root,
        			group => root,
				require => Package["ganglia-monitor"],
				notify  => Service["ganglia-monitor"],
				
	}


	service { "ganglia-monitor":
        ensure => running,
        enable => true,
        hasrestart => true,
	require => Package["ganglia-monitor"],
        }

}


class ganglia-server
{
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


	package { "ganglia-webfrontend": ensure => installed }
	
	file { "/etc/ganglia/gmetad.conf":
                                source => "puppet:///utils/fileserver-files/ganglia_conf/gmetad.conf",
                                owner=> root,
                                group => root,
                                require => Package["ganglia-webfrontend"],
				notify  => Service["gmetad","ganglia-monitor"],
        }

	file { "/etc/apache2/apache2.conf":
                                source => "puppet:///utils/fileserver-files/ganglia_conf/apache2.conf",
                                owner=> root,
                                group => root,
                                #require => Package["ganglia-webfrontend"],
				notify => Service["apache2"],
        }

	file { "/usr/share/ganglia-webfrontend/conf.php":
                                source => "puppet:///utils/fileserver-files/ganglia_conf/conf.php",
                                owner=> root,
                                group => root,
                                #require => Package["ganglia-webfrontend"],
                                #notify => Service["apache2"],
        }
	service { "gmetad":
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package["ganglia-webfrontend"],
        }

	service { "apache2":
        ensure => running,
        enable => true,
        hasrestart => true,
        #require => Package["ganglia-webfrontend"],
        }


}


















