#
# Copyright 2017, Don O'Neill (sntxrr+github@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Create a Hubot user
user 'hubot' do
   action :create #default action
   group "groupid"
end

# Clone the source code from GitHub.
git '/srv/hubot' do
  repository 'https://github.com/rrxtns/hangops-jobbot.git'
  action :checkout
end

# Install nodejs and hubot dependencies
include_recipe 'hangops-jobbot::nodejs'

# Create a system service.
service 'hubot' do
  init_command '/srv/hubot/bin/hubot --adapter slack'
  action :nothing
end

# drop the Hubot service file into place
# TODO: once we have a user recipe, change user to hubot
cookbook_file "/etc/systemd/system/hubot.service" do
  source "systemd.service"
  owner "sntxrr"
  mode "0644"
end

# Do some more stuff, then notify hubot to start
