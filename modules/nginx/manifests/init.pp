class nginx {
    package { 'nginx':
        ensure  => installed,
    }

    file { "/etc/nginx/sites-enabled/default":
      ensure  => absent,
      require => Package['nginx'],
      notify  => Service['nginx'],
    }

    file { '/etc/nginx/sites-enabled/rails-app':
        ensure  => file,
        content => template("nginx/rails-app.conf.erb"),
        require => Package['nginx'],
        notify  => Service['nginx'],
    }

    service { 'nginx':
        ensure  => running,
        enable  => true,
    }
}
