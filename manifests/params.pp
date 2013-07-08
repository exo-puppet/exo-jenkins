# Class: jenkins::params
#
# This class manage the jenkins parameters for different OS
class jenkins::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/ : {
      $package_name     = [
        'jenkins']
      $service_name     = 'jenkins'
      $jenkins_user     = 'jenkins'
      $jenkins_home     = $jenkins::jenkins_home ? {
        ''      => '/var/lib/jenkins',
        default => $jenkins::jenkins_home,
      }
      $jenkins_logs_dir = $jenkins::jenkins_logs_dir ? {
        ''      => '/var/log/jenkins',
        default => $jenkins::jenkins_logs_dir,
      } }
    default           : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
