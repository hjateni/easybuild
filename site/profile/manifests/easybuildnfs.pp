class profile::easybuildnfs {

  class { '::nfs':
    server_enabled => false,
    client_enabled => true,
    nfs_v4_client  => false,
  }
  
  Nfs::Client::Mount <<| |>>

}
