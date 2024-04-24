namespace :custom do
  desc 'Run assets precompile task to fix tailwindcss build bug'
  task :run_assets_precompile do
    on roles(:app) do
      execute "cd #{current_path}; pwd"
      execute "bundle exec rails assets:precompile"
      execute "/bin/systemctl --user restart even_blog_puma_production"
    end
  end
end