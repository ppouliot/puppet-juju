# == Define: juju::generic_config
#
define juju::generic_config () {
  case $name {
    'root':{
      $juju_home = "/root/"
    }
    default:{
      $juju_home = "/home/${name}/"
    }
  }
  exec{"juju_user-$name-generate_generic_config":
    command     => '/usr/bin/juju generate-config',
    environment => ["JUJU_HOME=${juju_home}"],
    cwd         => '${juju_home}',
    user        => $name,
    creates     => ["${juju_home}/.juju/",
                    "${juju_home}/.juju/environments.yaml",
                    "${juju_home}/.juju/ssh",
                    "${juju_home}/.juju/ssh/juju_id_rsa",
                    "${juju_home}/.juju/ssh/juju_id_rsa.pub"],
    onlyif      => "/usr/bin/test ! -f ${juju_home}/.juju",
    require     => User[$name],
    logoutput   => true,
  }

}
