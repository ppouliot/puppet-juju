# == Define: juju::generic_config
#
define juju::generic_config (
  $juju_user = $name,
){
  case $juju_user {
    'root':{
      $juju_home = "/root/"
    }
    default:{
      $juju_home = "/home/${name}/"
    }
  }
  exec {"juju_generate_generic_config-$name":
    command => '/usr/bin/juju generate-config',
    user    => $name,
    cwd     => $juju_home,
    creates => ["${juju_home}/.juju/",
                "${juju_home}/.juju/environments.yaml",
                "${juju_home}/.juju/ssh",
                "${juju_home}/.juju/ssh/juju_id_rsa",
                "${juju_home}/.juju/ssh/juju_id_rsa.pub"],
    onlyif    => "/usr/bin/test ! -f ${juju_home}/.juju",
  }
}
