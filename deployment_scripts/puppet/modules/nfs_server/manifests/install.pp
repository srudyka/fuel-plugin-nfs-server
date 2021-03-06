class nfs_server::install  {
  include nfs_server::params
  include nfs_server::firewall

  package { $nfs_server::params::pkg_name_server:
    ensure => installed,
  }
  file { 'nfs_dir':
    ensure  => directory,
    path    => $nfs_server::params::nfs_root_path,
  }
  file { 'exports':
    ensure  => present,
    path    => '/etc/exports',
    content => "${nfs_server::params::nfs_root_path} *(rw,sync,no_root_squash,no_subtree_check)\n",
    notify  => Service[$nfs_server::params::service_name]
  }
  service { $nfs_server::params::service_name:
    ensure    => running,
    enable    => true,
  }
}

