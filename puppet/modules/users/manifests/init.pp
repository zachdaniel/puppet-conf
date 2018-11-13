class users (
  $username,
  $groups,
  $home_dir
  ) {
  user { "$username" :
    home => $home_dir,
    groups => $groups,
    shell => "/bin/zsh"
  }
}
