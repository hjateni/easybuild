class profile::base {

  #the base profile should include component modules that will be on all nodes

  # ju ntp server
  class { '::ntp':
    servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  }

  class { '::hosts':

    dynamic_mode => true,

  }

  include '::vim'

  # apt repositories 

  include '::apt'

  # DNS lookups

  # user hpcadmin
  
  user {'hpcadmin':
    ensure	=> 'present',
    home	=> '/home/hpcadmin',
    shell	=> '/bin/bash',
  }

}
