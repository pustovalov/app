# config valid only for current version of Capistrano
# bundle exec cap production deploy
# bundle exec cap production rake task=db:seed
lock "3.4.0"
# set :use_sudo, true
set :repo_url, "https://github.com/pustovalov/app.git"
set :branch, "master"
set :deploy_to, "/home/deploy/applications/app"
# set :puma_threads, [4, 16]
# set :puma_workers, 0

set :stages, %w(staging production)
set :default_stage, "production"

set :log_level, :info
set :linked_files, %w{config/database.yml config/settings.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rbenv_type, :user
set :rbenv_ruby, "2.3.0"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil

set :puma_init_active_record, true

namespace :deploy do
  desc "Uploads keys"
  task :upload do
    on roles(:all) do
      upload! "config/application.yml", "#{release_path}/config/application.yml"
    end
  end
  after :publishing, :upload
end

desc "Run rake tasks on server"
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: :production do
        execute :rake, ENV["task"], "RAILS_ENV=production"
      end
    end
  end
end
