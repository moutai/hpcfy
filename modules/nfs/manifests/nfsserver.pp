class nfs{

	package { "nfs-kernel-server": ensure => installed }
	
	service { "nfs-kernel-server":
	ensure => running,
	enable => true,
	hasrestart => true, 
	require => Package["nfs-kernel-server"],
	}
	
	exec { "update-etc-exports":
	command => "/bin/cat /etc/exports.d/* >/etc/exports",
	notify => Service["nfs-kernel-server"],
	refreshonly => true,
	}
	
	
	define share( $path, $allowed, $options = "" ) {
		include nfs
		
		file { $path:
			ensure => directory,
		}
		
		file { "/etc/exports.d":
		ensure => directory,
		}
		
		file { "/etc/exports.d/${name}":
		content => "${path} ${allowed}(${options})\n",
		notify => Exec["update-etc-exports"],
		}
	}
	
}