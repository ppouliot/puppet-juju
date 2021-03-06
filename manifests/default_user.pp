# == Define: juju::default_user
#
# Define to manage juju group users
#
class juju::default_user(){
  group {'juju':
    ensure => 'present',
  }
->user{'juju':
    ensure     => 'present',
    comment    => 'juju',
    gid        => 'juju',
    home       => '/home/juju',
    managehome => true,
    password   => $juju::juju_password,
    shell      => '/bin/bash',
  }
->exec {'juju_default_user-generate_generic_config':
#   command     => '/usr/bin/juju generate-config',
    command     => '/usr/bin/juju autoload-credentials',
    environment => ['JUJU_HOME=/home/juju/.juju'],
    cwd         => '/home/juju',
    user        => 'juju',
    creates     => ['/home/juju/.juju/',
                    '/home/juju/.juju/environments.yaml',
                    '/home/juju/.juju/ssh',
                    '/home/juju/.juju/ssh/juju_id_rsa',
                    '/home/juju/.juju/ssh/juju_id_rsa.pub'],
    onlyif      => '/usr/bin/test ! -f /home/juju/.juju',
    require     => User['juju'],
    logoutput   => true,
  }
->file {'/home/juju/.juju':
    ensure  => directory,
    require => [ User['juju'], Exec['juju_default_user-generate_generic_config'] ],
  }
->file {'/home/juju/.juju/ssh':
    ensure  => directory,
    require => [ User['juju'], Exec['juju_default_user-generate_generic_config'] ],
  }
->file {[
    '/home/juju/.juju/ssh/juju_id_rsa',
    '/home/juju/.juju/ssh/juju_id_rsa.pub']:
    ensure  => file,
    require => [ User['juju'], Exec['juju_default_user-generate_generic_config'] ],
  }
# Moving to Environment.pp for testing
# ->
#  concat { '/home/juju/.juju/environments.yaml':
#    mode    => 0644,
#    require => [User['juju'], Exec['juju_default_user-generate_generic_config']],
#  }
#  concat::fragment {'juju.environtment.yaml_header':
#    target  => '/home/juju/.juju/environments.yaml',
#    content => template('juju/environments.header.erb'),
#    order   => 01,
#  }

}
