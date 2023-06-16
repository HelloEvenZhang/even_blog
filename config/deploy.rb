# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "even_blog"
set :repo_url, "https://github.com/HelloEvenZhang/even_blog.git"
set :branch, "release"

append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "storage", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", ".bundle", "public/system", "public/uploads"
