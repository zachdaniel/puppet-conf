class postgres {
  $home = lookup(users::home_dir)
  $user = lookup(users::username)

  if $facts['os']['family'] == 'Darwin' {
    package {'postgresql':
      provider => homebrew
    }
  } else {
    class {'postgresql::server':
    }
  }
}
