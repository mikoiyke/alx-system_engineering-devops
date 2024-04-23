exec { 'install_flask_with_pip3':
  command     => '/usr/bin/pip3 install Flask==2.1.0',
  path        => ['/usr/bin', '/usr/local/bin'],
  user        => 'root',
  environment => ['HOME=/root'],
  unless      => '/usr/bin/pip3 show Flask | grep -q "Version: 2.1.0"',
}
