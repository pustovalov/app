ip = "46.101.119.110"

role :app, ["deploy@#{ip}"]
role :web, ["deploy@#{ip}"]
role :db,  ["deploy@#{ip}"]

server ip, user: "deploy", roles: %w{web app db}, primary: true
# set :default_shell, '/bin/bash -l'
# set :stage, 'production'
# set :rails_env, 'production'
# set :use_sudo, true
# set :ssh_options, {
#   keys: %w(/home/deploy/.ssh/id_rsa.pub),
#   forward_agent: true,
#   auth_methods: %w(publickey)
# }
#
