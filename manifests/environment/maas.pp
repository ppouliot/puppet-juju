# == Define: juju::environment
# Defines a MAAS environment
#
# [*maas_server*]
#  the url of the maas api
# 
# [*maas_oauth*]
#  the api key of the user you are authenticating to the maas server as
# 
# [*bootstrap_timeout*]
#  the timeout for bootstrapping
# 
# [*enable_os_refresh_update*]
#  True or False
# 
# [*enable_os_upgrade*]
#  True or False
# 
define juju::environment::maas(

      $maas_server,
      $maas_oauth,
      $bootstrap_timeout,
      $enable_os_refresh_update
      $enable_os_upgrade
 ){ 

  validate_string($maas_server)
  validate_string($maas_oauth)
  validate_bool($enable_os_refresh_update)
  validate_bool($enable_os_upgrade)

}
