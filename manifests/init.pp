Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Packages -----------------------------------------------------------------

class misc {

	package {'git': ensure => installed }
	package { 'libmysqlclient-dev': ensure => installed }

}

class requirements {
  group { "puppet": ensure => "present", }
  exec { "apt-update":
    command => "apt-get -y update",
  }

}

class { requirements: }
class { misc: }

class { java: }
class { nginx: }
class { swap: }