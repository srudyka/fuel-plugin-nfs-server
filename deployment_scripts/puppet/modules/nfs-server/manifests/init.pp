
class nfs-server {
  include nfs_server::params

  $path = $nfs_server::params::nfs_root_path
  package { '$nfs_server::params::pkg_name_server':  
    ensure => installed, 
          }
  file { 'nfs_dir':
    path    => $path,
    ensure  => directory,
       }
  file { 'exports':
    path    => '/etc/exports',
    ensure  => present,
    content => "$path *(rw,sync,no_root_squash,no_subtree_check)\n",
    notify  => Service[$nfs_server::params::service_name],
      }
  service { $nfs_server::params::service_name:
    ensure    => running,
    enable    => true,
          }
}

