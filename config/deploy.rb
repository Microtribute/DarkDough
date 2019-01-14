require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, 'budget247'
set :repository,  'git@github.com:mb4nction/DarkDough.git'
set :rvm_type, :system

set :scm, :git

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
after 'deploy', 'deploy:migrate'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end