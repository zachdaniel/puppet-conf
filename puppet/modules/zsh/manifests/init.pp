class zsh {
  $home = lookup(users::home_dir)
  $puppet_path = lookup(puppet::path)
  $user = lookup(users::username)

  if $facts['os']['family'] == 'Darwin' {
    package { 'iterm2':
      provider => homebrew
    }

    package { 'zsh':
      provider => homebrew
    }

    package { 'wget':
      provider => homebrew
    }

    package{ 'caskroom/fonts':
      provider => tap
    }

    package{ 'font-firacode-nerd-font':
      require => Package['caskroom/fonts'],
      provider => homebrew
    }
  } else {
    package {'zsh':
    }

    package {'wget':
    }
  }

  exec {'install oh my zsh':
    command => '/usr/local/bin/wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh',
    require => [Package['zsh'], Package['wget']],
    user => $user,
    environment => ["HOME=${home}"]
  }

  vcsrepo { "${home}/.oh-my-zsh/custom/themes/powerlevel9k":
    ensure => latest,
    provider => git,
    source => 'https://github.com/bhilburn/powerlevel9k.git'
  }

  file { ["${home}/.zshrc.d", "${home}/.zshenv.d"]:
    ensure => 'directory',
    owner => $user
  }

  file { "${home}/.zshrc":
    ensure => link,
    target => "${puppet_path}/modules/zsh/files/.zshrc",
    owner => $user
  }

  file { "${home}/.zshenv":
    ensure => link,
    target => "${puppet_path}/modules/zsh/files/.zshenv",
    owner => $user
  }

  zsh::file { 'base.zsh':
    source_module_name => 'zsh',
    source_file_name => 'base.zsh',
    file_type => 'rc',
    zsh_file_name => 'base'
  }

  zsh::file { 'aliases.zsh':
    source_module_name => 'zsh',
    source_file_name => 'aliases.zsh',
    file_type => 'rc',
    zsh_file_name => 'aliases'
  }
}
