# == Define: juju::generic_config
#
define juju::generic_config (){
  case $name {
    'root':{ $basedir = "/${name}/" }
    default:{ $basedir = "/home/${name}/" }
  }
  exec {'juju_generate_generic_config':
    command => '/usr/bin/juju generate-config',
    user    => $name,
    cwd     => $basedir,
    creates => ["${basedir}/.juju/",
                "${basedir}/.juju/environments.yaml",
                "${basedir}/.juju/ssh"],
  }
}
