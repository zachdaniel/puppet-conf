class package_manager {
  $username = lookup(users::username)
  $home = lookup(users::home_dir)

  if $facts['os']['family'] == 'Darwin' {
    class { 'homebrew':
      user      => $username,
      multiuser => false,   # set to true to enable multiuser support for homebrew
    }

    zsh::file { 'package_path.zsh':
      source_module_name => 'package_manager',
      source_file_name => 'package_path.zsh',
      file_type => 'env',
      zsh_file_name => 'package_path'
    }
  }
}

