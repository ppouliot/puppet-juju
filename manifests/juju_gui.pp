# == Class: juju::juju_gui
# A class to deploy the juu Gui
#
class juju::juju_gui(

) inherits juju::params {
  exec { 'juju-deploy-juju-gui-to-0':
    command   => '/usr/bin/juju deploy juju-gui --to 0',
    user      => 'juju',
    pwd       => '/home/juju',
    timeout   => 0,
    logoutput => true,
    require   => [Package['juju'],User['juju']],
  }
}
