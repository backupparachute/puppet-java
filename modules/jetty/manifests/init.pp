Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class jetty {
  file {
    'jetty-conf':
      ensure => 'file',
      source => 'puppet:///modules/jetty/jetty.conf',
      path => '/etc/default/jetty',
      owner => 'root',
      group => 'root',
      mode  => '0744',
      notify => User['jetty'],
  }

  file {
    'setup-jetty':
      ensure => 'file',
      source => 'puppet:///modules/jetty/setup-jetty.sh',
      path => '/usr/local/bin/setup-jetty.sh',
      owner => 'root',
      group => 'root',
      mode  => '0744',
      notify => Exec['run_setup_jetty'],
  }

  exec {
    'run_setup_jetty':
     command => '/usr/local/bin/setup-jetty.sh',
     unless => ["test -f /opt/jetty/bin/jetty.sh"],
     notify  => Service['jetty'],
     require  => File['setup-jetty']
  }

  user { 'jetty':
    ensure   => "present",
    managehome => true,
    require => File['setup-jetty']
  }

  service { 'jetty':
      ensure  => running,
      enable  => true,
      require  => Exec['run_setup_jetty'],
  }

}
