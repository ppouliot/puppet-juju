# == Class: juju::environments
#
define juju::environment(
  $enable_os_upgrade,
) {
  validate_re($name, '(^amazon|openstack|hpcloud|manual|maas|local|joyent|gce|azure)$', 'This Module only works with the following Juju environments')
  case $name {
    'amazon':{
    }
    'openstack':{
        $environment_type     = 'openstack'
        $use_floating_ip      = false
        $use_default_secgroup = false
        $network              = undef
        $agent_metadata_url   = undef  
        $image_metadata_url   = undef
        $image_stream         = "released"
        $agent_stream         = "released"
        $auth_url             = undef
        $tenant_name          = undef
        $region               = undef
        $auth_mode            = undef
        $enable_os_refresh_update    = true
        $enable_os_upgrade           = true
        validate_re($name, '(^userpass|keypair)$', 'Your $auth_mode is not valid for Openstack environments require userpass or keypair as valid values!')
        case $auth_mode {
          'userpass':{ 
            validate_re($user_name, '($username)$', 'Auth-mode userpass requires a valid value for user_name!')
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
        }
    }
    'hpcloud':{
    }
    'manual':{
    }
    'maas':{
    }
    'local':{
    }
    'joyent':{
    }
    'gce':{
    }
    'azure':{
        $environment_type            = 'azure'
        $environment_location        = 'West US'
        $management_subscription_id  = undef
        $management_certificate_path = undef
        $storage_account_name        = undef 
        $force_image_name            = undef  
        $image_stream                = "released"
        $agent_stream                = "released"
        $enable_os_refresh_update    = true
        $enable_os_upgrade           = true
    }
  default:{
    fail("${name} is not a valid juju environment!")
  } 
}
