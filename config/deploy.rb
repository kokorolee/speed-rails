require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'


# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :forward_agent, true
set :ssh_options, '-A'
set :domain, '103.56.158.178'
set :deploy_to, '/home/webapp/goibacsi'
set :repository, 'git@bitbucket.org:harry88pham/goibacsi.git'
set :branch, 'master'
set :user, 'webapp'

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', '.env.production', 'tmp']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-2.3.0]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %[touch -p "#{deploy_to}/#{shared_path}/.env.production"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/.env.production"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/sidekiq.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/sidekiq.yml'."]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    invoke :'rails:db_migrate'

    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue! "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      # queue! "sudo /etc/init.d/sidekiq stop"
      # queue! "sudo /etc/init.d/sidekiq start"
    end
  end
end

task :restart do
  queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
end

RYAML = <<-BASH
function ryaml {
  ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' "$@"
};
BASH
namespace :sync do
  task :db do
    isolate do
      queue RYAML
      queue "USERNAME=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} username)"
      queue "PASSWORD=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} password)"
      queue "DATABASE=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} database)"
      queue "HOSTNAME=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} host)"
      queue "PGPASSWORD=$PASSWORD pg_dump -h $HOSTNAME -U $USERNAME $DATABASE -c -f #{deploy_to}/#{shared_path}/tmp/dump.sql"
      queue "gzip -f #{deploy_to}/#{shared_path}/tmp/dump.sql"

      mina_cleanup!
    end

    %x[scp #{user}@#{domain}:#{deploy_to}/#{shared_path}/tmp/dump.sql.gz .]
    %x[gunzip -f dump.sql.gz]
    %x[#{RYAML} psql -d $(ryaml config/database.yml development database) -f dump.sql]
    %x[rm dump.sql]
  end

  task :db_production do
    set :domain, '128.199.120.46'
    isolate do
      queue RYAML
      queue "USERNAME=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} username)"
      queue "PASSWORD=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} password)"
      queue "DATABASE=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} database)"
      queue "HOSTNAME=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} host)"
      queue "PGPASSWORD=$PASSWORD pg_dump -h $HOSTNAME -U $USERNAME $DATABASE -c -f #{deploy_to}/#{shared_path}/tmp/dump.sql"
      queue "gzip -f #{deploy_to}/#{shared_path}/tmp/dump.sql"

      mina_cleanup!
    end

    %x[scp #{user}@#{domain}:#{deploy_to}/#{shared_path}/tmp/dump.sql.gz .]
    %x[gunzip -f dump.sql.gz]
    %x[#{RYAML} psql -d $(ryaml config/database.yml development database) -f dump.sql]
    %x[rm dump.sql]
  end
end

