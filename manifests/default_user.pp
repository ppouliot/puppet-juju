# == Define: juju::default_user
#
# Define to manage juju group users
#
class juju::default_user (
) inherits params {

  group {'juju':
    ensure           => 'present',
  } ->
  user { 'juju':
    ensure           => 'present',
    comment          => 'juju',
    gid              => 'juju',
    home             => '/home/juju',
    managehome       => true,
    password         => $juju::juju_password,
    shell            => '/bin/bash',
  } 

#  juju::generic_config{'juju':
#    require => User['juju'],
#  } ->
#  file{"/home/juju/.juju":
#    ensure  => directory,
#    require => User['juju'],
#  } ->
#  file{"/home/juju/.juju/ssh":
#    ensure  => directory,
#    require => User['juju'],
#  } ->
#  file{[ "/home/juju/.juju/ssh/juju_id_rsa",
#         "/home/juju/.juju/ssh/juju_id_rsa.pub"]:
#    ensure  => file,
#    require => User['juju'],
#  }


#  concat { "/home/juju/.juju/environment.yaml":
#    mode    => 0644,
#  }
#  concat::fragment {"juju.environtment.yaml_header":
#    target  => "/home/juju/.juju/environment.yaml",
#    content => template("juju/environments.header.erb"),
#    order   => 01,
#  }
}
