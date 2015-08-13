# == Define: juju::default_user
#
class juju::default_user {
  user { 'juju':
    ensure           => 'present',
    comment          => 'juju',
    gid              => '0',
    home             => '/home/juju',
    password         => $juju::juju_password,
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '0',
  }

  juju::generic_config{'juju':} ->
  file{["/home/juju/.juju",
         "/home/juju/.juju/ssh",]:
    ensure => directory,
  } ->
  file{[ "/home/juju/.juju/ssh/juju_id_rsa",
         "/home/juju/.juju/ssh/juju_id_rsa.pub"]:
    ensure => file,
  }


  if ! defined (Concat["/home/juju/environment.yaml"]) {
    concat { "/home/juju/.juju/environment.yaml":
      mode    => 0644,
    }
  }
  if ! defined (Concat::Fragment["{$name}.juju.environtment.yaml_header"]) {
    concat::fragment {"'juju'.juju.environtment.yaml_header":
      target  => "/home/'juju'/.juju/environment.yaml",
      content => template("juju/environment.header.erb"),
      order   => 01,
    }
  }
}
