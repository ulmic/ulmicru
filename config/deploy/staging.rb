server 'ulmic.ru', user: 'ulmic', roles: %w{web app db}

set :application, 'ulmic_stg'
set :deploy_to, '/srv/ulmic_stg'
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :rails_env, :staging
set :branch, "develop"

namespace :deploy do
  task :restart do
    puts "DONT DEPLOY TO STAGING!!!! DONT!!!"
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
    invoke 'sidekiq:stop'
  end

  after :publishing, :restart
end
