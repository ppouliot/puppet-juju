# == Define: juju::user
#
define juju::user {
  user { '${name}':
    ensure           => 'present',
    comment          => '${name}',
    gid              => '0',
    home             => '/home/${name}',
    password         => '${name}',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '0',
  } ->

  juju::generic_config{$name:} ->

  file {["/home/${name}/.juju",
         "/home/${name}/.juju/ssh",
         "/home/${name}/.juju/ssh",
         "/home/${name}/.juju/ssh/juju_id_rsa",
         "/home/${name}/.juju/ssh/juju_id_rsa.pub"]:
   ensure => present,
  }

  if ! defined (Concat["/home/${name}/environment.yaml"]) {
    concat { "/home/${name}/.juju/environment.yaml":
      mode    => 0644,
    }
  }
  if ! defined (Concat::Fragment["{$name}.juju.environtment.yaml_header"]) {
    concat::fragment {"${name}.juju.environtment.yaml_header":
      target  => "/home/${name}/.juju/environment.yaml",
      content => template("juju/environment.header.erb")
      order   => 01,
    }
  }
}
