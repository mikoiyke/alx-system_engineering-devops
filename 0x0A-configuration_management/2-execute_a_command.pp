# Puppet Manifest: Kill the 'killmenow' process

exec { 'kill_killmenow_process':
  command     => '/bin/pkill killmenow',
  onlyif      => '/bin/pgrep killmenow',
  path        => ['/usr/bin'],
  user        => 'root',
}
