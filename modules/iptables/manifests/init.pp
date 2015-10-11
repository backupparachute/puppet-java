class iptables {
  package { 'iptables':
      ensure  => installed,
  }

  file {
    'iptables-conf':
      ensure => 'file',
      source => 'puppet:///modules/iptables/iptables.conf',
      path => '/etc/default/iptables',
      owner => 'root',
      group => 'root',
      mode  => '0744',
      require => Package['iptables'],
      notify => File['setup-iptables'],
  }

  file {
    'setup-iptables':
      ensure => 'file',
      source => 'puppet:///modules/iptables/iptables-restore.conf',
      path => '/etc/init/iptables-restore.conf',
      owner => 'root',
      group => 'root',
      mode  => '0744',
      require => Package['iptables'],
      notify => Service['iptables'],
  }

  service { 'iptables':
      ensure  => running,
      enable  => true,
      require  => File['setup-iptables'],
  }

}
