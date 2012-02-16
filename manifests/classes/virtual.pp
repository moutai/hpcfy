# virtual.pp
#
# People accounts of interest as virtual resources
# The dependencies can get confusing here.

class virtual_users {
#    package { "ruby-shadow":
#      ensure => installed
#    }

    @user { "hpcuser":
        ensure  => "present",
        uid     => "5006",
        gid     => "5006",
        comment => "HPC user",
        home    => "/home/hpcuser",
        shell   => "/bin/bash",
        managehome => true,
        #password => '$1$5dZQgQSq$POqlSWnuiYZ7d1VXfgXGo.',
        require => [Group["hpcuser"]]
    }
    
        
    exec { "genkey":
        command => "su hpcuser -c \"ssh-keygen -P '' -t  rsa -f /home/hpcuser/.ssh/id_rsa\"",
        cwd => "/root",
        creates => "/home/hpcuser/.ssh/id_rsa",
        require => User["hpcuser"],
        ##unless => "cat /home/hpcuser/.ssh/id_rsa",
    }
#
#    exec { "authkey":
#        command => "cat ./id_rsa.pub >> ./authorized_keys",
#        cwd => "/home/hpcuser/.ssh/",
#        creates => "/home/hpcuser/.ssh/authorized_keys",
#        require => Exec["genkey"],
#        #unless => "cat /home/hpcuser/.ssh/authorized_keys",
#    }

	file {"/home/hpcuser":
        ensure => directory,
        owner=> hpcuser,
		group => hpcuser,
		require => User["hpcuser"],
    }
	
    file {"/home/hpcuser/.ssh":
        ensure => directory,
        owner=> hpcuser,
		group => hpcuser,
        require => File["/home/hpcuser"],
    }

#    file {"/home/hpcuser/.ssh/id_rsa":
#       #content => template("ssh_keys/keys/id_rsa"),
#       #ensure => present,
#       owner=> hpcuser,
#       group => hpcuser,
#       mode => 600,
#       require => [User["hpcuser"],Exec["genkey"],Exec["authkey"]],
#    }
#
#    file {"/home/hpcuser/.ssh/id_rsa.pub":
#        #content => template("ssh_keys/keys/id_rsa.pub"),
#        #ensure => present,
#        owner=> hpcuser,
#        group => hpcuser,
#        mode => 600,            
#        require => [User["hpcuser"],Exec["genkey"],Exec["authkey"]],
#        
#    }
#
#    file { "/home/hpcuser/.ssh/authorized_keys":
#        mode => 600,
#        owner => hpcuser,
#        group => hpcuser,
#        require => [User["hpcuser"],Exec["genkey"],Exec["authkey"]],
#    }

#    ssh_authorized_key {"hpcuser@clusternodeX":
#        type => ssh-rsa,
#        key => template("ssh_keys/keys/authorized_keys"),
#        user => user,
#        target => "/home/hpcuser/.ssh/authorized_keys",
#        ensure => present,
#        require => User["hpcuser"],
#    }


#    sshkey {"hpcuser":
#        type => ssh-rsa,
#        key => template("ssh_keys/keys/authorized_keys"),
#    }
}

class virtual_groups {
    @group { "hpcuser":
        ensure  => "present",
        gid     => "5006", 
    }

}

