################################################################################
#
#   This module manages the jenkins service.
#
#   Tested platforms:
#    - Ubuntu 11.10 Oneiric
#    - Ubuntu 11.04 Natty
#    - Ubuntu 10.04 Lucid
#
#
# == Parameters
#   [+ensure+]
#       (OPTIONAL) (default: present)
#       
#       this variable allows to choose if jenkins must be present and which version (values : "present", "latest", a version) 
#
#   [+java_args+]
#       (OPTIONAL) (default: ["-Xmx256m"])
#       
#       this variable allows to choose java process arguments used to launch Jenkins  
#
#   [+http_port+]
#       (OPTIONAL) (default: 8080)
#       
#       this variable allows to choose the HTTP port for jenkins service (values : a port number or -1 to deactivate)  
#
#   [+ajp_port+]
#       (OPTIONAL) (default: -1)
#       
#       this variable allows to choose the AJP port for jenkins service (values : a port number or -1 to deactivate)  
#
#   [+jenkins_home+]
#       (OPTIONAL) (default: system defined)
#       
#       this variable allows to choose the path of the jenkins home directory  
#
#   [+jenkins_logs_dir+]
#       (OPTIONAL) (default: system defined)
#       
#       this variable allows to choose the path of the jenkins logs directory  
#
# == Modules Dependencies
#
# [+repo+]
#   the +repo+ puppet module is needed to :
#   
#   - refresh the repository before installing package (in jenkins::install)
#
# == Examples
#
#   class { "jenkins":
#       ensure => "1.449",
#   }
#
################################################################################
class jenkins ( $ensure = present, $java_args = ["-Xmx256m"], $http_port = "8080", $ajp_port = "-1", $jenkins_home = "", $jenkins_logs_dir = "" ) {

    include repo
    include jenkins::params, jenkins::install, jenkins::config, jenkins::service
}