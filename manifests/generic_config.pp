# == Define: juju::generic_config
#
define juju::generic_config ($juju_username = $name){
  case $juju_username {
    'root':{ $basedir = "/${juju_username}/" }
    default:{ $basedir = "/home/${juju_username}/" }
  }
  exec {'juju_generate_generic_config':
    command => '/usr/bin/juju generate-config',
    user    => $name,
    cwd     => $basedir,
    creates => ['${basedir}/.juju/',
                '${basedir}/.juju/environments.yaml',
                '${basedir}/.juju/ssh'],
  }
}
