# Class: corp104_prerender
# ===========================
#
# Full description of class corp104_prerender here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'corp104_prerender':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class corp104_prerender (
  Optional[String] $http_proxy,
  Optional[String] $nvm_dir,
  Optional[String] $remote_source,
  String $prerender_user,
  String $prerender_group,
  String $bashrc,
  String $package_name,
  String $package_provider,
  String $service_name,
  String $service_ensure,
  String $access_log_package_name,
  String $node_version,
  Optional[String] $install_path,
  Optional[String] $server_bin,
  String $chrome_source_tmp,
  Optional[Array] $chrome_flags,
  Integer $page_done_check_interval,
  Array $depend_on_chrome_packages,
  String $chrome_source,
  String $log_path,
  String $log_file_format,
  String $log_frequency,
  String $log_date_format,
  String $log_verbose,
  String $pid_dir,
  String $init_conf,
){
  contain corp104_prerender::install
  contain corp104_prerender::config
  contain corp104_prerender::service

  Class['::corp104_prerender::install']
  -> Class['::corp104_prerender::config']
  ~> Class['::corp104_prerender::service']
}
