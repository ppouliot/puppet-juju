# == Class: juju
#  moreinfo 
#  https://juju.ubuntu.com/docs/
#
# Full description of class juju here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# [*version*]
#   Specify a version of Juju to install
#
# [*ensure*]
#   Valid options are 'present' or 'absent'
#
# [*juju_release*]
#   Release to use for juju packages
#
# [*juju_packages*]
#   Default Juju Packages to install 
#
# [*juju_packages*]
#   Default Juju Packages to install 
#
# [*juju_password*]
#   Password for the system user account named 'juju' which is the 
#   account use this modules uses for charm bootstraping
#
# [*juju_jitsu*]
#   If set to true, juju-jitsu package will we installed
#
# [*juju_gui*]
#   If set to true, juju-gui package will we installed
#
#
# === Examples
#
#  Basic Usage
#  -----------
#  class{'juju':}
#
#  Installing Juju and Juju-Jitsu 
#  ------------------------------
#  class { 'juju':
#    juju_jitsu => true,
#  }
#
# === Authors
#
# Peter J. Pouliot <peter@pouliot.net>
#
# === Copyright
#
# Copyright 2015 Peter J. Pouliot <peter@pouliot.net>, unless otherwise noted.
#
class juju (
  Optional[String] $version = undef,
  String $ensure            = present,
  String $juju_release_ppa  = 'stable',
  String $package_name      = 'juju',
  String $juju_password     = 'juju',
  Boolean $juju_jitsu       = false,
  Boolean $manage_package   = true,
  String $default_provider  = 'maas',
){
  if $::operatingsystem {
    assert_type(Pattern[/(^Ubuntu)$/], $::operatingsystem) |$a, $b| {
      fail('This Module only works on Ubuntu based systems.')
    }
  }
  if $::operatingsystemrelease {
    assert_type(Pattern[/(^12.04|14.04|16.04|18.04)$/], $::operatingsystemrelease) |$a, $b| {
      fail('This Module only works on Ubuntu releases 14.04, 16.04 and 18.04.')
    }
  }
  if ($juju::juju_release_ppa) {
    assert_type(Pattern[/(^stable|devel)$/], $juju_release_ppa) |$a, $b| {
      fail('This Module supports the Juju "stable" and "devel" releases.')
    }
  }
  case $::operatingsystem {
    'Ubuntu':{
      case $::operatingsystemrelease {
        '14.04','16.04','18.04':{
          notice("Installing Juju on your ${::operatingsystemrelease}")
        }
        default:{
          warning("This is currently untested on your ${::operatingsystemrelease}")
        }
      }
    }
    default:{
      fail("This is not meant for this ${::operatingsystem}")
    }
  }
  notice("Juju on node ${::fqdn} is managed by the juju puppet module." )

  class{'::juju::install':}
->class{'::juju::default_user':}
->class{'::juju::config':}

  contain 'juju::install'
  contain 'juju::default_user'
  contain 'juju::config'
}
