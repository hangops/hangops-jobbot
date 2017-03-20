
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

# Install hubot-flip
execute 'install-hubot-flip' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-flip --save'
end

# Install hubot-redis-brain
execute 'install-hubot-redis-brain' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-redis-brain --save'
end

# Install hubot-slack
execute 'install-hubot-slack' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-slack --save'
end

# Install hubot-slack-whitelist-middleware
execute 'install-hubot-slack-whitelist-middleware' do
  command 'cd /srv/hangops-jobbot;' \
          'sudo npm install ' \
          '/srv/hangops-jobbot/vendor/' \
          'hubot-slack-whitelist-middleware --save'
end
