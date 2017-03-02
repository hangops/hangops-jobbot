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

require 'poise/utils'
require 'poise_application/service_mixin'
require 'poise_languages/utils'

require 'poise_application_javascript/app_mixin'


module PoiseApplicationJavascript
  # A helper mixin for Javascript service resources and providers.
  #
  # @since 1.0.0
  module ServiceMixin
    include Poise::Utils::ResourceProviderMixin

    # A helper mixin for Javascript service resources.
    module Resource
      include PoiseApplication::ServiceMixin::Resource
      include PoiseApplicationJavascript::AppMixin::Resource
    end

    # A helper mixin for Javascript service providers.
    module Provider
      include PoiseApplication::ServiceMixin::Provider
      include PoiseApplicationJavascript::AppMixin::Provider

      # Set up the service for running Javascript stuff.
      def service_options(resource)
        super
        # Closure scoping for #javascript_command below.
        self_ = self
        # Create a new singleton method that fills in `node` for you.
        resource.define_singleton_method(:javascript_command) do |val|
          resource.command("#{self_.new_resource.javascript} #{PoiseLanguages::Utils.absolute_command(val, path: self_.new_resource.app_state_environment_javascript['PATH'])}")
        end
        # Include env vars as needed.
        resource.environment.update(new_resource.parent_javascript.javascript_environment) if new_resource.parent_javascript
      end

    end
  end
end
