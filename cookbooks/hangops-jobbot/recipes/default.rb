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

application '/srv/hubot' do
  # Clone the source code from GitHub.
  git 'https://github.com/rrxtns/hangops-jobbot.git'

  # Install the latest Node.js.
  javascript 'nodejs'
  
  # Install coffeescript globally.
  node_package 'coffeescript' do
    global true
  end
  
  # Run `npm install` to install dependencies.
  npm_install
  
  # Create a system service.
  javascript_service '/srv/hubot/bin/hubot'
end