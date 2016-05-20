# Class: jenkins::install
#
# This class manage the installation of the jenkins package
class jenkins::install {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      file { '/etc/default/jenkins':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 0644,
        content => template('jenkins/etc/default/jenkins.erb'),
        notify  => Class['jenkins::service'],
      }

      apt::source { 'jenkins':
        location => $jenkins::stable_repo ? {
          true    => 'http://pkg.jenkins-ci.org/debian-stable',
          default => 'http://pkg.jenkins-ci.org/debian',
        },
        release  => 'binary/',
        repos    => '',
        key      => {
          'id'     => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
          # 'source' => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
          'server' => 'keyserver.ubuntu.com',
        },
        include  => {
          'src' => false,
          'deb' => true,
        },
      }

      ensure_packages ( 'jenkins', {
        'ensure'  => $jenkins::ensure,
        'name'    => $jenkins::params::package_name,
        'require' => [Apt::Source['jenkins'],Class['apt::update'],File['/etc/default/jenkins']] } )
    }
  }
}
