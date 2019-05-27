class corp104_prerender::service inherits corp104_prerender {
  file { $corp104_prerender::pid_dir:
    ensure => directory,
    mode   => '0755',
  }

  file { $corp104_prerender::init_conf:
    ensure  => file,
    mode    => '0755',
    content => template("${module_name}/prerender.init.erb"),
  }

  service { 'prerender':
    ensure => $corp104_prerender::service_ensure,
    name   => $corp104_prerender::service_name,
  }
}