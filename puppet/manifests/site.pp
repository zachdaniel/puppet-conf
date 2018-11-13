node default {
  # I honestly forget which bug this fixed.
  unless $facts['os']['family'] == 'Darwin' {
    package { 'lsb-release':
      ensure => installed,
    }
  }

  include zsh
  include users
  include git
  include package_manager
  include postgres
  include emacs
  include apps
  include ruby
  include elixir
}
