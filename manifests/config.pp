class corp104_prerender::config inherits corp104_prerender {
  file { "${corp104_prerender::install_path}/${corp104_prerender::server_bin}":
    ensure  => file,
    mode    => '0766',
    content => template("${module_name}/server-daemon.js.erb"),
    # notify  => Service['prerender'],
  }
}
