# Automate the task of creating a custom HTTP header response
# Configuration for HTTP response header

package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

file { '/var/www/html/404.html':
  content => 'Ceci n\'est pas une page',
}

exec { 'update-apt':
  command => '/usr/bin/apt update',
  path    => '/usr/bin',
  require => Package['nginx'],
}

service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => Package['nginx'],
}

$hostname = $facts['hostname']

file_line { 'add_header':
  path    => '/etc/nginx/sites-enabled/default',
  line    => "    add_header X-Served-By $hostname;",
  match   => 'server_name _',
  after   => 'server_name _;',
  require => Package['nginx'],
}

exec { 'set-redirect':
  command => '/bin/sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/github.com\/mikoiyke permanent;/" /etc/nginx/sites-enabled/default',
  path    => '/bin',
  require => Package['nginx'],
}

exec { 'nginx-restart':
  command     => '/usr/sbin/service nginx restart',
  refreshonly => true,
  subscribe   => [File_line['add_header'], Exec['set-redirect']],
}

exec { 'test-nginx':
  command     => '/usr/sbin/nginx -t',
  refreshonly => true,
  subscribe   => Exec['nginx-restart'],
}

