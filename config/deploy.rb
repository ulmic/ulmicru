# config valid only for Capistrano 3.2.1
set :application, 'ulmicru'
set :repo_url, 'git@github.com:ulmic/ulmicru.git'

set :rvm_type, :system
set :rvm_ruby_version, 'ruby-2.1.1'
set :use_sudo, false
#set :sidekiq_service_name, "sidekiq"

#set :sidekiq_default_hooks, false

# set :whenever_environment, defer { stage }
# set :whenever_roles, [:web]

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/srv/ulmicru'
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :ssh_options, {
  forward_agent: true
}

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %w{config/secrets.yml config/oauth.yml config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
set :precompile_cmd             # default: bundle exec rake assets:precompile
set :assets_dir                 # default: "public/assets"
set :rsync_cmd                  # default: "rsync -av"

set :turbosprockets_enabled     # default: false
set :turbosprockets_backup_dir  # default: "public/.assets"
set :cleanexpired_cmd           # default: bundle exec rake assets:clean_expired

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
    invoke 'sidekiq:restart'
  end

  after :publishing, :restart
end

#namespace :unicorn do
#  namespace :monit do
#    desc "start unicorn"
#    task :start do
#      on roles(:app) do
#        sudo "/usr/bin/monit start unicorn"
#      end
#    end
#
#    desc "stop unicorn"
#    task :stop do
#      on roles(:app) do
#        sudo "/usr/bin/monit stop unicorn"
#      end
#    end
#
#    desc "restart unicorn"
#    task :restart do
#      on roles(:app) do
#        sudo "/usr/bin/monit restart unicorn"
#      end
#    end
#  end
#end

#namespace :deploy do
#  desc 'Restart application'
#  task :restart do
#    on roles(:app), in: :sequence, wait: 5 do
#      # invoke 'unicorn:reload'
#      invoke 'unicorn:monit:restart'
#      # Your restart mechanism here, for example:
#      # execute :touch, release_path.join('tmp/restart.txt')
#    end
#  end
#
#  after :publishing, "deploy:restart" #:restart
#  after :published, "sidekiq:monit:restart"
#
#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
#    end
#  end
#end
