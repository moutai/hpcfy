
add_user { hpcuser:
                email    => "go@email.com",
                uid      => 5001
        }


add_ssh_key { hpcuser:
                key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAwtnN3Nmkn8WKfBUs4/AwCmthfsY6TXmEe63d2Okeo3QtpUvceXj83bVqerK6h62bEGb7LtE2oW8utiE8ZlWmeViMdIZo6OQVOMj69HgPZu3IKSIYW5hTVWhb5FmQOOtGk5m1uxJyeBI5ivmVJtQIrH6gOkoOP1X23PqLCUnb1Wur9J6NCAOOLtJQEl+CMTSRqNZ6VU/4Kvu0FxSiAqHdi5i4zpob3HIWXSC0Ugh664jqvjjJI7ZLuC4Ym3BFK+uZKVX3yKIx0sbiZm+IMBvuUJzmpfPTMPrMyZuq7FxSUjIv+TX4XKwxv8ysU39k1WllOYT5kDwkOnJ5NLt4zqJQVQ==",
                type    => "ssh-rsa"
        }



define add_user ( $email, $uid ) {

            $username = $title

            user { $username:
                    comment => "$email",
                    home    => "/home/$username",
                    shell   => "/bin/bash",
                    uid     => $uid
            }

            group { $username:
                    gid     => $uid,
                    require => user[$username]
            }

            file { "/home/$username/":
                    ensure  => directory,
                    owner   => $username,
                    group   => $username,
                    mode    => 750,
                    require => [ user[$username], group[$username] ]
            }

            file { "/home/$username/.ssh":
                    ensure  => directory,
                    owner   => $username,
                    group   => $username,
                    mode    => 700,
                    require => file["/home/$username/"]
            }

            exec { "/narnia/tools/setuserpassword.sh $username":
                    path            => "/bin:/usr/bin",
                    refreshonly     => true,
                    subscribe       => user[$username],
                    unless          => "cat /etc/shadow | grep $username| cut -f 2 -d : | grep -v '!'"
            }

            # now make sure that the ssh key authorized files is around
            file { "/home/$username/.ssh/authorized_keys":
                    ensure  => present,
                    owner   => $username,
                    group   => $username,
                    mode    => 600,
                    require => file["/home/$username/"]
            }
    }
    
    
    
    
    define add_ssh_key( $key, $type ) {

            $username       = $title

            ssh_authorized_key{ "${username}_${key}":
                    ensure  => present,
                    key     => $key,
                    type    => $type,
                    user    => $username,
                    require => file["/home/$username/.ssh/authorized_keys"]

            }

    }
    
    
