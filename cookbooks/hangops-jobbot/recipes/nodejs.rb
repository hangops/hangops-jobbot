
# apt update
include_recipe 'apt::default'

# Install the latest Node.js. default action install included for clarity
package 'nodejs' do
  action :install
  retries 3
end

package 'npm' do
  action :install
  retries 3
end

# Install coffeescript globally. default action install included for clarity
nodejs_npm 'coffeescript' do
  action :install
end

# Ubuntu needs a symlink
# TODO: detect Ubuntu, and only do this if we're on Ubuntu
link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end

# Run `npm install` to install dependencies
execute 'install-dependencies' do
  command 'cd /srv/hangops-jobbot;sudo npm install'
end

# Install hubot-diagnostics
execute 'install-hubot-diagnostics' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-diagnostics --save'
end

# Install hubot-flip
execute 'install-hubot-flip' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-flip --save'
end

# Install hubot-google-images
execute 'install-hubot-google-images' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-google-images --save'
end

# Install hubot-google-translate
vartr = 'cd /srv/hangops-jobbot;sudo npm install hubot-google-translate --save'
execute 'install-hubot-google-translate' do
  command vartr
end

# Install hubot-help
execute 'install-hubot-help' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-help --save'
end

# Install hubot-heroku-keepalive
execute 'install-hubot-heroku-keepalive' do
  command 'cd /srv/hangops-jobbot;' \
          'sudo npm install hubot-heroku-keepalive --save'
end

# Install hubot-maps
execute 'install-hubot-maps' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-maps --save'
end

# Install hubot-pugme
execute 'install-hubot-pugme' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-pugme --save'
end

# Install hubot-redis-brain
execute 'install-hubot-redis-brain' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-redis-brain --save'
end

# Install hubot-rules
execute 'install-hubot-rules' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-rules --save'
end

# Install hubot-scripts
execute 'install-hubot-scripts' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-scripts --save'
end

# Install hubot-shipit
execute 'install-hubot-shipit' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-shipit --save'
end

# Install hubot-slack
execute 'install-hubot-slack' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-slack --save'
end

# Install hubot-slack
execute 'install-hubot-slack' do
  command 'cd /srv/hangops-jobbot;' \
          'sudo npm install hubot-slack-whitelist-middleware --save'
end
