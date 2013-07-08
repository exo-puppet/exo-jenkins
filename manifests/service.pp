# Class: jenkins::service
#
# This class manage the jenkins service
class jenkins::service {
  service { 'jenkins':
    ensure     => running,
    name       => $jenkins::params::service_name,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['jenkins::config'],
  }
}
