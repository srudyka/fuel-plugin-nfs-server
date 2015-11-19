
class nfs-server {
  $path = '/nfs'
  package { 'nfs-kernel-server':  
  ensure => installed, 
          }
  file { 'nfs_dir':
  path    => '/nfs',
  ensure  => directory,
       }
  file { 'exports':
  path    => '/etc/exports',
  ensure  => present,
  content => "$path *(rw,sync,no_root_squash,no_subtree_check)\n",
  notify  => Service[nfs-kernel-server],
      }
  service { nfs-kernel-server:
  ensure    => running,
  enable    => true,
    }
}

