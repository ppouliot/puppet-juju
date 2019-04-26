# == Class:juju::install
# 
# class to install an update-to-date version of juju from
# the default package repository or the Cloud-Archive repo
# This installs on Ubunt based distributions only.
class juju::install {
  notice("JUJU installation is occuring on node ${::fqdn}." )
  case $::operatingsystem {
    'Ubuntu':{
      if ($juju::juju_release_ppa) {
        include ::apt
        notice("Node ${::fqdn} is using the juju ${juju::juju_release_ppa} package repository for JUJU installation." )
        apt::ppa{"ppa:juju/${juju::juju_release_ppa}":}
        if ($juju::manage_package) {
          Apt::Ppa["ppa:juju/${juju::juju_release_ppa}"] -> Package['juju']
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
        }
        case $::operatingsystemrelease {
          '14.04':{
            notice("Installing charm-tools form charm authoring on your ${::operatingsystemrelease}")
            package{'charm-tools':
              ensure  => $juju::ensure,
              require => Package['juju'],
            }
            if $juju::juju_jitsu != false {
              package{'juju-jitsu':
                ensure => $juju::ensure,
              }
            }
          }
          default:{
            warning("There is no charm-tools deb provided for Ubuntu ${::operatingsystemrelease}")
          }
        }
      }
    }
    default:{
      fail("Juju does not support installation on your operation system: ${::osfamily} ")
    }
  }
}
