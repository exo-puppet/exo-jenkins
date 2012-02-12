# Class: jenkins::config
#
# This class manage the jenkins configuration
class jenkins::config {
    # configure agent daemon/service to start at boot time or not
    case $::operatingsystem {
        /(Ubuntu|Debian)/: {
            file { "/etc/default/jenkins":
                ensure => file,
                owner  => root,
                group  => root,
                mode   => 0644,
                content => template("jenkins/etc/default/jenkins.erb"),
                require => Class["jenkins::install"],
                notify => Class["jenkins::service"],
            }
        }
        default: {
            fail ("The ${module_name} module is not supported on $::operatingsystem")
        }
    }        
    file { ["${jenkins::params::jenkins_home}","${jenkins::params::jenkins_logs_dir}"]:
        ensure => directory,
        owner  => $jenkins::params::jenkins_user,
        group  => $jenkins::params::jenkins_user,
        mode   => 0644,
        require => Class["jenkins::install"],
        notify => Class["jenkins::service"],
    }
}
