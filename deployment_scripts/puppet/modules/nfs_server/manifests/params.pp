#
#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
class nfs_server::params {
  $nfs_server_hash = hiera('nfs-server')
  $nfs_root_path   = $nfs_server_hash['export_path']

  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      $pkg_name_server      = 'nfs-kernel-server'
      $pkg_name_client      = 'nfs-common'
      $service_name         = 'nfs-kernel-server'
    }
    'CentOS', 'RedHat': {
      $pkg_name_server      = 'nfs-kernel-server'
      $pkg_name_client      = 'nfs-common'
      $service_name         = 'nfs'
    }
    default: {
      fail("unsuported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
    }
  }

}
