# == Class: juju::params
#
# === Authors
#
# Peter J. Pouliot <peter@pouliot.net>
#
# === Copyright
#
# Copyright 2015 Peter J. Pouliot <peter@pouliot.net>, unless otherwise noted.
#
class juju::params {
  case $operatingsystem {
    'Ubuntu':{
      case $operatingsystemrelease {
        '14.04':{
          $version                       = undef
          $ensure                        = present 
          $prerequired_packages          = undef
          $manage_package                = true
          $juju_password                 = 'juju'
          $juju_release                  = 'stable'
          $juju_jitsu                    = false
          $package_name                  = 'juju'
          $default_provider              = 'amazon'
        }
        default:{
          warning("This is currently untested on your ${operatingsystemrelease}")
        }
      }
    }
    default:{
      warning("This is not meant for this ${operatingsystem}")
    }
  }
}
