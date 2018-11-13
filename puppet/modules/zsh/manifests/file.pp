define zsh::file ($source_module_name, $source_file_name, $zsh_file_name, $file_type) {
  $puppet_path = lookup(puppet::path)
  $home = lookup(users::home_dir)
  $user = lookup(users::username)

  if $file_type == "env" {
    $folder = ".zshenv.d"
  } elsif $file_type == "rc" {
    $folder = ".zshrc.d"
  } else {
    fail("${file_type} is not a valid zsh file type")
  }

  file { "${home}/${folder}/${zsh_file_name}.zsh" :
    ensure => link,
    target => "${puppet_path}/modules/${source_module_name}/files/${source_file_name}",
    mode => "+x",
    owner => $user
  }
}
