class ruby {
  package{'ruby':
    ensure => present,
    provider => homebrew
  }
}
