
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

name             'hubot-jobbot'
maintainer       'Akbar Enterprises'
maintainer_email 'sntxrr+github@gmail.com'
license          'All rights reserved'
description      'Installs/Configures hubot-jobbot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.4'

name 'hangops-jobbot'

depends 'nodejs', '~> 3.0.0'
