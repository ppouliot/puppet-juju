# == Define: juju::generic_config
#
define juju::generic_config (){
  case $name {
    'root':{ $basedir = undef }
    default:{ $basedir = '/home' }
  }
  exec {'juju_generate_generic_config':
    command => '/usr/bin/juju generate-config',
    user    => $name,
    cwd     => "${basedir}/${name}",
    creates => ['${basedir}/${name}/.juju/',
                '${basedir}/${name}/.juju/environments.yaml',
                '${basedir}/${name}/.juju/ssh'],
  }
}
