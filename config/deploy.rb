# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "even_blog"
set :repo_url, "https://github.com/HelloEvenZhang/even_blog.git"
set :branch, "release"

append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "storage", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", ".bundle", "public/system", "public/uploads"

namespace :deploy do
  namespace :assets do
    before :precompile, :build_tailwindcss do
      on release_roles(fetch(:assets_roles)) do
        within release_path do
          with rails_env: fetch(:rails_env), rails_groups: fetch(:rails_assets_groups) do
            execute :rails, "assets:precompile"
          end
        end
      end
    end
  end
end