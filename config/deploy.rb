# require "bundler/capistrano"

set :rbenv_ruby, File.read('.ruby-version').strip
set :ssh_options, { :forward_agent => false, :user => "fguillen" }
set :application, "KontraBandoFilmFestival"
set :repo_url, "git@github.com:fguillen/KontraBandoFilmFestival.git"
set :log_level, :debug
set :use_sudo, false
set :keep_releases, 5
set :migration_role, :app

namespace :customs do
  task :symlink do
    on roles(:app) do
      # execute "ln -nfs #{shared_path}/system/database.yml #{current_path}/config/database.yml"
      # execute "ln -nfs #{shared_path}/system/app_config.yml #{current_path}/config/app_config.yml"

      execute "mkdir -p #{shared_path}/db"
      execute "ln -nfs #{shared_path}/db/#{rails_env}.sqlite3 #{current_path}/db/#{rails_env}.sqlite3"

      execute "rm -rf #{current_path}/log"
      execute "mkdir -p #{shared_path}/log"
      execute "ln -nfs #{shared_path}/log #{current_path}/log"
    end
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Restart app"
  task :restart do
    on roles(:app) do
      execute "mkdir -p #{current_path}/tmp"
      execute "touch #{current_path}/tmp/restart.txt"
    end
  end
end

after "deploy", "customs:symlink"
after "deploy", "deploy:cleanup"
after "deploy", "deploy:restart"

