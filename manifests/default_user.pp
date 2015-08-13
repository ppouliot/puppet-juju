# == Define: juju::default_user
#
class juju::default_user {

  group {'juju':
    ensure           => 'present',
  } ->
  user { 'juju':
    ensure           => 'present',
    comment          => 'juju',
    gid              => 'juju',
    home             => '/home/juju',
    password         => $juju::juju_password,
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
  } ->

  juju::generic_config{'juju':} ->
  file{["/home/juju/.juju",
         "/home/juju/.juju/ssh",]:
    ensure => directory,
  } ->
  file{[ "/home/juju/.juju/ssh/juju_id_rsa",
         "/home/juju/.juju/ssh/juju_id_rsa.pub"]:
    ensure => file,
  }


  concat { "/home/juju/.juju/environment.yaml":
    mode    => 0644,
  }
  concat::fragment {"juju.environtment.yaml_header":
    target  => "/home/juju/.juju/environment.yaml",
    content => template("juju/environments.header.erb"),
    order   => 01,
  }
}
