# == Class: juju::environments
#
class juju::environments($environment) {
  validate_re($environment, '(^amazon|openstack|hpcloud|manual|maas|local|joyent|gce|azure)$', 'This Module only works with the following Juju environments')
}
