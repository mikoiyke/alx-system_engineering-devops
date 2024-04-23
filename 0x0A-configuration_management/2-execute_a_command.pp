# Puppet Manifest: Kill the 'killmenow' process

exec { 'kill_killmenow_process':
  command     => '/bin/killmenow $(/bin/pgrep killmenow)',
  onlyif      => '/bin/pgrep killmenow',
  path        => ['/bin', '/usr/bin'],
  user        => 'root',
}
