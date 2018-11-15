# == Class: juju::environment
#
define juju::environment(
  $juju_environment = $name,
  #maas
  $maas_server      = undef,
  $maas_oath        = undef,
){
  validate_re($juju_environment, '(^amazon|openstack|hpcloud|manual|maas|local|joyent|gce|azure)$', 'This Module only works with the following Juju environments') #lint:ignore:140chars
  case $juju_environment {
    'amazon':{
      $environment_type     = 'ec2'
      $region               = 'us-east-1'
      $access_key           = undef
      $secret_key           = undef
      $image_stream         = 'released'
      $agent_stream         = 'released'
      $enable_os_refresh_update    = true
      $enable_os_upgrade           = true
    }
    'openstack':{
      $environment_type     = 'openstack'
      $use_floating_ip      = false
      $use_default_secgroup = false
      $network              = undef
      $agent_metadata_url   = undef
      $image_metadata_url   = undef
      $image_stream         = 'released'
      $agent_stream         = 'released'
      $auth_url             = undef
      $tenant_name          = undef
      $region               = undef
      $auth_mode            = undef
      $enable_os_refresh_update    = true
      $enable_os_upgrade           = true
      validate_re($name, '(^userpass|keypair)$', 'Your $auth_mode is not valid for Openstack environments require userpass or keypair as valid values!') #lint:ignore:140chars
      case $auth_mode {
        'userpass':{
          validate_re($::user_name, '($username)$', 'Auth-mode userpass requires a valid value for user_name!')
          validate_re($password, '($password)$', 'Auth-mode userpass requires valid a value for password!')
          $username = undef
          $password = undef
        }
        'keypair':{
          validate_re($access_key, '($access_key)$', 'Authmode keypair requires valid a value for access_key!')
          validate_re($secret_key, '($secret_key)$', 'Authmode keypair requires valid a value for secret_key!')
          $access_key = undef
          $secret_key = undef
        }
        default:{
          warning("${::authmode} must be set for proper use of OpenStack providers")
        }
      }
    }
    'hpcloud':{
      $environment_type     = 'openstack'
      $use_floating_ip      = true
      $use_default_secgroup = false
      $network              = undef
      $agent_metadata_url   = undef
      $image_metadata_url   = undef
      $image_stream         = 'released'
      $agent_stream         = 'released'
      $auth_url             = undef
      $tenant_name          = undef
      $region               = undef
      $auth_mode            = undef
      $enable_os_refresh_update    = true
      $enable_os_upgrade           = true
      validate_re($name, '(^userpass|keypair)$', 'Your $auth_mode is not valid for Openstack environments require userpass or keypair as valid values!') #lint:ignore:140chars
      case $auth_mode {
        'userpass':{
          validate_re($::user_name, '($username)$', 'Auth-mode userpass requires a valid value for user_name!')
          validate_re($password, '($password)$', 'Auth-mode userpass requires valid a value for password!')
          $username = undef
          $password = undef
        }
        'keypair':{
          validate_re($access_key, '($access_key)$', 'Auth-mode keypair requires valid a value for access_key!')
          validate_re($secret_key, '($secret_key)$', 'Auth-mode keypair requires valid a value for secret_key!')
          $access_key = undef
          $secret_key = undef
        }
        default:{
          warning("${::authmode} must be set for proper use of HPCLOUD providers")
        }
      }
    }
    'manual':{
      $environment_type         = 'manual'
      $bootstrap_host           = undef
      $bootstrap_user           = undef
      $storage_listen_ip        = undef
      $storage_port             = '8040'
      $enable_os_refresh_update = true
      $enable_os_upgrade        = true
    }
    'maas':{
      $environment_type         = 'maas'
      $maas_server              = undef
      $maas_oauth               = undef
      $bootstrap_timeout        = '1800'
      $enable_os_refresh_update = true
      $enable_os_upgrade        = true
    }
    'local':{
      $environment_type         = 'local'
      $root_dir                 = undef
      $storage_port             = '8040'
      $network_bridge           = undef
      $default_series           = 'trusty'
      $enable_os_refresh_update = true
      $enable_os_upgrade        = true
    }
    'joyent':{
      $environment_type         = 'joyent'
      $sdc_user                 = undef
      $sdc_key_id               = undef
      $sdc_url                  = 'https://us-west-1.api.joyentcloud.com'
      $manta_user               = undef
      $manta_url                = 'https://us-east.manta.joyent.com'
      $private_key_path         = undef
      $algorithm                = 'rsa-sha256'
      $enable_os_refresh_update = true
      $enable_os_upgrade        = true
    }
    'gce':{
      $environment_type = 'gce'
      $auth_file        = undef
      $private_key      = undef
      $client_email     = undef
      $client_id        = undef
      $project_id       = undef
      $region           = 'us-central1'
      $image_endpoint   = 'https://www.googleapis.com'
    }
    'azure':{
      $environment_type            = 'azure'
      $environment_location        = 'West US'
      $management_subscription_id  = undef
      $management_certificate_path = undef
      $storage_account_name        = undef
      $force_image_name            = undef
      $image_stream                = 'released'
      $agent_stream                = 'released'
      $enable_os_refresh_update    = true
      $enable_os_upgrade           = true
    }
    default:{
      fail("${name} is not a valid juju environment!")
    }
  }
  if ! defined (Concat['/home/juju/.juju/environments.yaml']) {
    concat { '/home/juju/.juju/environments.yaml':
      mode => '0644',
    }
  }
  if ! defined (Concat::Fragment['juju.environtment.yaml_header']) {
    concat::fragment {'juju.environtments.yaml_header':
      target  => '/home/juju/.juju/environments.yaml',
      content => template('juju/environments.header.erb'),
      order   => '01',
    }
  }
  if ! defined (Concat::Fragment["${name}.juju.environtment"]) {
    concat::fragment {"${name}.juju.environtment":
      target  => '/home/juju/.juju/environments.yaml',
      content => template("juju/environments.${name}.erb"),
      order   => '02',
    }
  }
}
