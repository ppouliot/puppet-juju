# == Class: juju::params
#
#
# === Parameters
#
# === Variables
#
# [*juju_release*]
#   Release to use for juju packages
#   Valid options are 'stable'.
#
# [*juju_packages*]
#   Default JUJU Packages to install
#
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
          $juju_release                  = 'stable'
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
