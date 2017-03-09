
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

# Run `npm install` to install dependencies
execute 'install-dependencies' do
  command 'cd /srv/hangops-jobbot;sudo npm install'
end

# Install the Slack adapter
execute 'install-hubot-slack' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-slack --save'
end

# Install the Redis brain plugin
execute 'install-hubot-redis-brain' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-redis-brain --save'
end

# Install Hubot diagnostics
execute 'install-hubot-diagnostics' do
  command 'cd /srv/hangops-jobbot;sudo npm install hubot-diagnostics --save'
end

# Ubuntu needs a symlink
# TODO: detect Ubuntu, and only do this if we're on Ubuntu
link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end
