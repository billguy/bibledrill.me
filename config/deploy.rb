# config valid only for current version of Capistrano
lock '3.4.0'

set :passenger_restart_with_touch, true
set :application, 'BibledrillMe'
set :repo_url, 'git@github.com:billguy/bibledrill.me.git'

APP_CONFIG = YAML.load_file("config/config.yml")["production"]

server APP_CONFIG['deploy_host'], user: APP_CONFIG['deploy_user'], roles: %w{app db web}

set :tmp_dir, "#{APP_CONFIG['deploy_to']}/tmp"
set :whenever_command,      ->{ [:bundle, :exec, :whenever] }
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/config.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'private', 'public/ckeditor_assets')

set :keep_releases, 2

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end