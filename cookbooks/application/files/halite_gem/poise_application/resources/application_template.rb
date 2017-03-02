#
# Copyright 2015, Noah Kantrowitz
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

require 'poise_application/app_file_mixin'

module PoiseApplication
  module Resources
    # (see ApplicationTemplate::Resource)
    # @since 5.1.0
    module ApplicationTemplate
      # An `application_template` resource to manage Chef templates inside and
      # Application cookbook deployment.
      #
      # @provides application_template
      # @action create
      # @action create_if_missing
      # @action delete
      # @action touch
      # @example
      #   application '/srv/myapp' do
      #     template 'myapp.conf' do
      #       source 'myapp.conf.erb'
      #     end
      #   end
      class Resource < Chef::Resource::Template
        include PoiseApplication::AppFileMixin
        provides(:application_template)
        actions(:create, :create_if_missing, :delete, :touch)
        subclass_providers!

        def initialize(*args)
          super
          # For older Chef.
          @resource_name = :application_template
        end
      end
    end
  end
end
