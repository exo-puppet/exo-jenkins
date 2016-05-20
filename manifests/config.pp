# Class: jenkins::config
#
# This class manage the jenkins configuration
class jenkins::config {

  if !defined(File[$jenkins::params::jenkins_home]) {
    file { [
      $jenkins::params::jenkins_home]:
      ensure  => directory,
      owner   => $jenkins::params::jenkins_user,
      group   => $jenkins::params::jenkins_user,
      mode    => 0644,
      require => Class['jenkins::install'],
      notify  => Class['jenkins::service'],
    }
  }

  file { [
    $jenkins::params::jenkins_logs_dir]:
    ensure  => directory,
    owner   => $jenkins::params::jenkins_user,
    group   => $jenkins::params::jenkins_user,
    mode    => 0644,
    require => Class['jenkins::install'],
    notify  => Class['jenkins::service'],
  }
}
