# Puppet Manifest: Install Flask version 2.1.0 using pip3
file { '/tmp/school':
  ensure  => present,
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => "I love Puppet\n",
}
