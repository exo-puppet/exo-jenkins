# Class: jenkins::install
#
# This class manage the installation of the jenkins package
class jenkins::install {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      repo::define { "jenkins-repo":
        file_name    => "jenkins",
        url          => $jenkins::stable_repo ? {
          true    => "http://pkg.jenkins-ci.org/debian-stable",
          default => "http://pkg.jenkins-ci.org/debian",
        },
        distribution => "binary/",
        source       => false,
        key          => "D50582E6",
        notify       => Exec["repo-update"],
      }

      package { "jenkins":
        name    => $jenkins::params::package_name,
        ensure  => $jenkins::ensure,
        require => [
          Repo::Define["jenkins-repo"],
          Exec["repo-update"]],
      }
    }
  }
}