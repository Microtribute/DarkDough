require "bundler/capistrano"

set :application, "blog_app"
set :user, "mark"
set :scm_passphrase, "p@ssw0rd"

set :scm, :git
#set :repository, "https://github.com/YOUR_GITHUB_ACCOUNT/YOUR_REPO.git"
set :repository, "https://github.com/mb4nction/DarkDough.git"
set :branch, "master"
set :use_sudo, true

#server "YOUR_IP_ADDRESS_HERE", :web, :app, :db, primary: true
server "10.175.152.96", :web, :app, :db, primary: true
    
set :deploy_to, "/home/#{user}/apps/#{application}"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    sudo "mkdir -p #{shared_path}/config"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    # Add database config here
  end
  after "deploy:finalize_update", "deploy:symlink_config"
end