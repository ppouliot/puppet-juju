# == Class: juju::generic_config
#
class juju::generic_config {
  exec {'juju_generate_generic_config':
    command => '/usr/bin/juju generate-config',
    user    => 'root',
    cwd     => '/root',
    creates => '/root/.juju/environments.yaml'
  }
}
