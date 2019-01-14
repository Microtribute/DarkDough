set :dns_name, 'budget247.com'

role :web, dns_name                          # Your HTTP server, Apache/etc
role :app, dns_name                          # This may be the same as your `Web` server
role :db,  dns_name, :primary => true        # This is where Rails migrations will run

set :deploy_to, '/home/budget247'

set :rails_env, 'production'
set :branch, 'master'
set :use_sudo, false

set :user, 'budget247'
set :port, 22