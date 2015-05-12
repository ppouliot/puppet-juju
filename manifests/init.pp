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
#   Specify a version of MAAS to install
#
# [*ensure*]
#   Valid options are 'present' or 'absent'
#
# [*juju_release*]
#   Release to use for juju packages
#
# [*juju_packages*]
#   Default MAAS Packages to install 
#
# [*juju_packages*]
#   Default MAAS Packages to install 
#
# === Examples
#
#  class { 'juju':
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

  $version                    = $juju::params::version,
  $ensure                     = $juju::params::ensure,
  $prerequired_packages       = $juju::params::prerequired_packages,
  $juju_release               = $juju::params::juju_release,
  $juju_packages              = $juju::params::juju_packages,
  $package_name               = $juju::params::package_name,
  $manage_package             = $juju::params::manage_package,

) inherits juju::params {

  validate_string($version)
  validate_re($::operatingsystem, '(^Ubuntu)$', 'This Module only works on Ubuntu based systems.')
  validate_re($::operatingsystemrelease, '(^12.04|14.04)$', 'This Module only works on Ubuntu releases 12.04 and 14.04.')
  notice("MAAS on node ${::fqdn} is managed by the juju puppet module." )

  if ($juju_release) {
    validate_string($juju_release, '^(stable)$', 'This module only supports the Stable Releases')
  }

  class{'juju::install':} -> 
  class{'juju::config':}

  contain 'juju::install'
  contain 'juju::config'
}
