set :stage, :staging
set :rails_env, "staging"
set :branch, "staging"
role :app, "staging.kontrabandofilmfestival.org"
role :web, "staging.kontrabandofilmfestival.org"
set :deploy_to, "/home/www/staging.kontrabandofilmfestival.org"

