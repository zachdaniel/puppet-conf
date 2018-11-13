class emacs {
  $home = lookup(users::home_dir)
  $puppet_path = lookup(puppet::path)
  $user = lookup(users::username)

  file { "${home}/Development":
    ensure => directory
  }

  vcsrepo { "${home}/.emacs.d/":
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/hlissner/doom-emacs.git',
    revision => 'develop',
    owner => $user
  }

  file { "${home}/.doom.d/":
    ensure => link,
    target => "${puppet_path}/modules/emacs/files/.doom.d/"
  }

  if $facts['os']['family'] == 'Darwin' {
    package {'font-source-code-pro':
      provider => 'homebrew',
      require => Package['caskroom/fonts']
    }

    package {'font-fira-code':
      provider => 'homebrew',
      require => Package['caskroom/fonts']
    }

    package{'editorconfig':
      provider => homebrew
    }

    package{'gnu-tar':
      provider => homebrew
    }

    package{'ispell':
      provider => homebrew
    }

    # Think this is required just for a mac bug
    file { "${home}/.gnupg":
      ensure => directory,
    }

    file { "${home}/.gnupg/gpg-agent.conf":
      ensure => link,
      target => "${puppet_path}/modules/emacs/files/gpg-agent.conf",
      owner => $user
    }

    package { 'pinentry-mac':
      provider => homebrew
    }

    package {'sqlite':
      provider => homebrew
    }

    ## end mac bug required thing

    package {'pandoc':
      ensure => present,
      provider => homebrew
    }

    package { 'ag':
      ensure => present,
      provider => homebrew
    }

    package { 'd12frosted/emacs-plus':
      ensure   => present,
      provider => tap,
    }

    package { 'emacs-plus':
      require => Package['d12frosted/emacs-plus'],
      ensure   => present,
      provider => homebrew,
      install_options => ["--HEAD", "--with-natural-title-bars"]
    }

    file { '/Applications/Emacs.app':
      require => Package['emacs-plus'],
      ensure => link,
      target => "/usr/local/Cellar/emacs-plus/*/Emacs.app/",
      owner => $user
    }
  } else {
    include apt

    package {'emacs':
    }
  }
}
