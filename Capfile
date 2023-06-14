require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require "capistrano/bundler"
require "capistrano/rbenv"
require "capistrano/rails"
require "capistrano/puma"
require "capistrano/puma/nginx"

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::Puma::Systemd

set :rbenv_type, :user
set :rbenv_ruby, '3.2.0'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
