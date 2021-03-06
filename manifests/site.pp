## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
#https://docs.puppet.com/pe/2015.3/release_notes.html#filebucket-resource-no-longer-created-by-default
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }

}
 node 'mclient','mclient2' {

 user {'sora':
      ensure => 'present',
      uid    => '6000',
      gid    => 'root',
      home   => '/home/sora',
      shell  => '/bin/bash',
      managehome => true,
 }
 class { '::nfs':
    client_enabled => true,
  }
  Nfs::Client::Mount <<| |>>
    
   # include java
   # include graphlab::cluster::slave
   # include '::role::hpcclient' 
   # include '::role::account'
 }
 
node 'mserver' {


 user {'hpcadmin':
      ensure => 'present',
      uid  => '5004',
      gid  => 'root',
      home => '/home/hpcadmin',
      shell => '/bin/bash',
                 
    }


file {'/home/vagrant/software':

    ensure => 'directory',
    owner => 'root',
    mode  => '0766',
    path => '/home/vagrant/software',

}

class { '::rkhunter':
  root_email => 'jateni.halake@ju.edu.et',
  tftp => true,
}

class { '::nfs':
    server_enabled => true
  }
  nfs::server::export{ '/home/vagrant/software':
    ensure  => 'mounted',
    clients => '192.168.1.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
  }


  # include '::role::hpcsoftware'
  # include java
  # include graphlab::cluster::master
 }
