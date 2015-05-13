package { "openjdk-7-jdk":
	ensure => "installed"
}

class my::network {
	$fullname = "$hostname.$fqdn"
	notice("Network config for $fullname...") 
	
	host { "master.$fqdn":
		ip => $master_ipaddress,
		host_aliases => 'master',
	}
	unless $hostname == 'master' {
		host { "$fullname":
			ip => $ipaddress,
			host_aliases => $hostname,
		}
	}
	
	file_line { 'add_domain':
        path   => '/etc/resolv.conf',
        line   => "domain $fqdn",
    } ->
	file { '/etc/hostname':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => 644,
        content => "${hostname}\n",
    } ~>
	exec { 'hostname.sh':
        command     => '/etc/init.d/hostname.sh start',
        refreshonly => true,
        #notify      => Service['puppet'],
    }
}

class my::hadoop {
    class { 'cdh::hadoop':
        # Logical Hadoop cluster name.
        cluster_name       => 'mycluster',
        # Must pass an array of hosts here, even if you are
        # not using HA and only have a single NameNode.
        namenode_hosts     => ['192.168.33.11'],  # TODO abstract name selection
        datanode_mounts    => [
            '/var/lib/hadoop/data/a',
            '/var/lib/hadoop/data/b',
            '/var/lib/hadoop/data/c'
        ],
        # You can also provide an array of dfs_name_dirs.
        dfs_name_dir       => '/var/lib/hadoop/name',
    }
}

class my::hadoop::master inherits my::hadoop {
    include cdh::hadoop::master
}

class my::hadoop::worker inherits my::hadoop {
    include cdh::hadoop::worker
}

node /^client[1234]$/ {
    include my::hadoop
}

node 'master' {
    require my::network
    # include my::hadoop::master
}

node /^datanode[1234]$/ {
    include my::hadoop::worker
}