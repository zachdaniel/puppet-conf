class git {
  $user = lookup(users::username)
  $home = lookup(users::home_dir)
  $puppet_path = lookup(puppet::path)

  file{"${home}/.gitconfig":
    ensure => link,
    target => "${puppet_path}/modules/git/files/.gitconfig",
    owner => $user
  }

  file{"${home}/.gitignore":
    ensure => link,
    target => "${puppet_path}/modules/git/files/.gitignore",
    owner => $user
  }
}
