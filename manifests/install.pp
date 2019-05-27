class corp104_prerender::install inherits corp104_prerender {
  user { $corp104_prerender::prerender_user: ensure => present }
  group { $corp104_prerender::prerender_group: ensure => present }

  ####################
  # Node JS Install
  ####################
  if $corp104_prerender::http_proxy {
    class { 'corp104_nvm':
      node_version => $corp104_prerender::node_version,
      set_default  => true,
      http_proxy   => $corp104_prerender::http_proxy,
    }

    # exec { 'npm-install-prerender':
    #   provider    => 'shell',
    #   environment => ["https_proxy=${corp104_prerender::http_proxy}", "http_proxy=${corp104_prerender::http_proxy}"],
    #   command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; npm install -g ${corp104_prerender::package_name}",
    #   path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    #   unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; npm list ${corp104_prerender::package_name}",
    #   require     => Class['corp104_nvm'],
    # }
  }
  else {
    class { 'corp104_nvm':
      node_version => $corp104_prerender::node_version,
      set_default  => true,
    }

    # exec { 'npm-install-prerender':
    #   provider => 'shell',
    #   command  => ". ${corp104_prerender::nvm_dir}/nvm.sh; npm install -g ${corp104_prerender::package_name}",
    #   path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    #   unless   => ". ${corp104_prerender::nvm_dir}/nvm.sh; npm list ${corp104_prerender::package_name}",
    #   require  => Class['corp104_nvm'],
    # }
  }

  ####################
  # Prerender Install
  ####################
  if $corp104_prerender::remote_source {
    file { $corp104_prerender::install_path:
      ensure => directory,
      mode   => '0755',
      before => Archive['/tmp/prerender.zip'],
    }

    archive { '/tmp/prerender.zip':
      ensure          => present,
      extract_path    => '/opt',
      extract         => true,
      source          => $corp104_prerender::remote_source,
      cleanup         => true,
      proxy_server    => $corp104_prerender::http_proxy,
      checksum_verify => false,
    }

    file { "${corp104_prerender::install_path}/package.json":
      ensure  => file,
      content => template("${module_name}/package.json.erb"),
    }
  }

  if $corp104_prerender::http_proxy {
    exec { 'npm-install-prerender-package':
      provider => 'shell',
      environment => ["https_proxy=${corp104_prerender::http_proxy}", "http_proxy=${corp104_prerender::http_proxy}"],
      command  => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install",
      path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless   => "test -d ${corp104_prerender::install_path}/node_modules",
      require  => Class['corp104_nvm'],
    }

    exec { 'npm-install-prerender':
      provider    => 'shell',
      environment => ["https_proxy=${corp104_prerender::http_proxy}", "http_proxy=${corp104_prerender::http_proxy}"],
      command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::access_log_package_name}",
      path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::package_name}",
      require     => Exec['npm-install-prerender-package'],
    }

    exec { 'npm-install-prerender-access-log':
      provider    => 'shell',
      environment => ["https_proxy=${corp104_prerender::http_proxy}", "http_proxy=${corp104_prerender::http_proxy}"],
      command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::access_log_package_name}",
      path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::access_log_package_name}",
      require     => Exec['npm-install-prerender'],
    }
  }
  else {
    exec { 'npm-install-prerender-package':
      provider => 'shell',
      command  => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install",
      path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless   => "test -d ${corp104_prerender::install_path}/node_modules",
      require  => Class['corp104_nvm'],
    }

    exec { 'npm-install-prerender':
      provider    => 'shell',
      command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::package_name}",
      path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::package_name}",
      require     => Exec['npm-install-prerender-package'],
    }

    exec { 'npm-install-prerender-access-log':
      provider    => 'shell',
      command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::access_log_package_name}",
      path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::access_log_package_name}",
      require     => Exec['npm-install-prerender'],
    }

  }

  #################################
  # Prerender Access Log Install
  #################################
  # if $corp104_prerender::http_proxy {
  #   exec { 'npm-install-prerender-access-log':
  #     provider    => 'shell',
  #     environment => ["https_proxy=${corp104_prerender::http_proxy}", "http_proxy=${corp104_prerender::http_proxy}"],
  #     command     => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::access_log_package_name}",
  #     path        => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
  #     unless      => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::access_log_package_name}",
  #     require     => Class['corp104_nvm'],
  #   }
  # }
  # else {
  #   exec { 'npm-install-prerender-access-log':
  #     provider => 'shell',
  #     command  => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm install ${corp104_prerender::package_name}",
  #     path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
  #     unless   => ". ${corp104_prerender::nvm_dir}/nvm.sh; cd ${corp104_prerender::install_path}; npm list ${corp104_prerender::package_name}",
  #     require  => Class['corp104_nvm'],
  #   }
  # }

  file { $corp104_prerender::log_path:
    ensure => directory,
  }

  ####################
  # Chrome Install
  ####################
  package { $corp104_prerender::depend_on_chrome_packages:
    ensure => present,
    before => Package['google-chrome-stable'],
  }

  if $corp104_prerender::http_proxy {
    exec { 'download-chrome-source':
      provider => 'shell',
      command  => "curl -x ${corp104_prerender::http_proxy} -o ${corp104_prerender::chrome_source_tmp} -O ${corp104_prerender::chrome_source}",
      path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless   => "test -e ${corp104_prerender::chrome_source_tmp}",
    }
  }
  else {
    exec { 'download-chrome-source':
      provider => 'shell',
      command  => "curl -o ${corp104_prerender::chrome_source_tmp} -O ${corp104_prerender::chrome_source}",
      path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless   => "test -e ${corp104_prerender::chrome_source_tmp}",
    }
  }

  package { 'google-chrome-stable':
    ensure   => present,
    provider => $corp104_prerender::package_provider,
    source   => $corp104_prerender::chrome_source_tmp,
  }
}


