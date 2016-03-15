# == Class:juju::install
# 
# class to install an update-to-date version of juju from
# the default package repository or the Cloud-Archive repo
# This installs on Ubunt based distributions only.

class juju::install {
  validate_string($juju::version)
  validate_bool($juju::juju_jitsu)
  validate_re($::operatingsystem, '(^Ubuntu)$', 'This Module only works on Ubuntu based systems.')
  validate_re($::operatingsystemrelease, '(^12.04|14.04)$', 'This Module only works on Ubuntu releases 12.04 and 14.04.')
  notice("JUJU installation is occuring on node ${::fqdn}." )

  case $operatingsystem {
    'Ubuntu':{
      if ($juju::juju_release) {
        include ::apt
        notice("Node ${::fqdn} is using the juju ${juju::juju_release} package repository for JUJU installation." )
        apt::ppa{"ppa:juju/${juju::juju_release}":}
        if ($juju::manage_package) {
          Apt::Ppa["ppa:juju/${juju::juju_release}"] -> Package['juju']
        }
      } else {
        if $juju::version and $juju::ensure != 'absent' {
          $ensure = $juju::version
        } else {
          $ensure = $juju::ensure
        }
      }

      if $juju::version {
        $jujupackage = "${juju::package_name}-${juju::version}"
      } else {
        $jujupackage = $juju::package_name
      }

      if $juju::manage_package {
        package { 'juju':
          ensure => $juju::ensure,
          name   => $jujupackage,
        } ->
        package{'charm-tools':
          ensure => $juju::ensure,
        }
        if $juju::juju_jitsu != false {
          package{'juju-jitsu':
            ensure => $juju::ensure,
          }
        }
    }

    default:{
      fail("JUJU does not support installation on your operation system: ${::osfamily} ")
    }
  }
}
