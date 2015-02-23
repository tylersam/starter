# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'hawkeye2'
set :repo_url, 'https://github.com/tylersam/hawkeye2.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/tylersam/webapps/hawkeye2'
set :shared_path, '/home/tylersam/webapps/hawkeye2/shared'
set :tmp_dir, '/home/tylersam/tmp'

set :rvm_ruby_version, '2.0.0'
#set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :bundle_flags, ''

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :linked_files, %w{config/database.yml config/local_env.yml}

namespace :deploy do

  desc "Restart nginx"
  task :restart do
    on roles(:app) do
      execute "$HOME/webapps/hawkeye2/bin/restart"
    end


  end


  after :deploy, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
