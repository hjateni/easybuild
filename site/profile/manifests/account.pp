
 class profile::account {

   user { 'bob':
      uid      => 4001,
      gid      => 4001,
      shell    => '/bin/bash',
      home     => '/home/bob'
      # password => '!!',
      # sshkeys  => "ssh-rsa AAAA...",
      # locked   => false,
}
}
