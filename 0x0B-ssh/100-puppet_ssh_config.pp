file { '/home/your_user/.ssh/config':
  ensure  => present,
  content => "
    Host 54.84.159.69
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
",
}
