# using puppetlabs/apt for better apt control
class { 'apt': }

# setup nodejs ppa for rails js dependencies
apt::ppa { 'ppa:chris-lea/node.js': }

# locale / encoding for proper UTF support on postgres
class { 'postgresql::globals':
  version => '9.3',
  manage_package_repo => true,
  encoding => 'UTF8',
  locale => 'en_US.UTF-8'
}

class { 'postgresql::server':
  listen_addresses => '*',
}

# need psql + devel packages + contrib for potential posgresql modeuls
class { 'postgresql::client': }

class { 'postgresql::lib::devel': }

class { 'postgresql::server::contrib': }

# default users to rails_development and rails_test
postgresql::server::role { ['rails_development', 'rails_test']:
  createdb => true,
  superuser => true,
}

# see docs: http://www.postgresql.org/docs/9.2/static/auth-pg-hba-conf.html
postgresql::server::pg_hba_rule { 'allow local connections':
  type => 'local',
  database => 'all',
  user => 'all',
  auth_method => 'trust',
  order => '002'
}

postgresql::server::pg_hba_rule { 'allow remote connections':
  type => 'host',
  database => 'all',
  user => 'all',
  auth_method => 'trust',
  address => '0.0.0.0/0',
  order => '002'
}

# set postgresql user creation dependency
Class['postgresql::server'] -> Postgresql::Server::Role <| |>

# tmux / vim is personal perference, nodejs + sqlite + git are for dev requirements
package {
  "screen":
    ensure => latest;
  "git":
    ensure => latest;
  "vim":
    ensure => latest;
  "s3cmd":
    ensure => latest;
  "libsqlite3-dev":
    ensure => present;
  "nodejs":
    require => Apt::Ppa['ppa:chris-lea/node.js'],
    ensure => latest;
  # required for phantomjs
  "fontconfig":
    ensure => latest;
  # capybara webkit
  "firefox":
    ensure => latest;
  "xvfb":
    ensure => latest;
  "libqt4-dev":
    ensure => latest;
  "libqtwebkit-dev":
    ensure => latest;
  "libmysql-ruby":
    ensure => latest;
  "libmysqlclient-dev":
    ensure => latest;
  "bash-completion":
    ensure => latest;
}

# rbenv module is alup/rbenv
rbenv::install { "vagrant":
  group => 'vagrant',
  home  => '/home/vagrant'
}

rbenv::compile { "2.1.2":
  user => "vagrant",
  home => "/home/vagrant",
  global => true
}

rbenv::gem { ['puppet', 'foreman', 'envs']:
  user => 'vagrant',
  ruby => '2.1.2',
  home => "/home/vagrant"
}

file { 'code directory':
  path => '/home/vagrant/code',
  ensure => directory
}

# redis setup
class { 'redis':
  version => '2.8.13'
}

class { 'ohmyzsh': }

ohmyzsh::install { 'vagrant': }
