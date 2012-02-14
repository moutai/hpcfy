class user{

	user { 'hpcuser':
	    home       => '/home/hpcuser',   # home directory is /home/admin
	    managehome => true,            # manage the home directory by Puppet
	    groups     => ['hpcuser'],       # the user belongs to wheel group
	    #password   => 'PASSWORD_HASH', # hashed password text
	}
    
}