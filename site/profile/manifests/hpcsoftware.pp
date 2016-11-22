class profile::hpcsoftware {

  file {
    '/home/hpcadmin/software':
      ensure => directory;
  }

}
