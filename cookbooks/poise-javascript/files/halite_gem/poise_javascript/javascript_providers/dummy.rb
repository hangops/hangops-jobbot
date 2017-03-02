#
# Copyright 2015-2016, Noah Kantrowitz
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

require 'poise_javascript/javascript_providers/base'

module PoiseJavascript
  module JavascriptProviders
    # Inversion provider for the `javascript_runtime` resource to use a fake Javascript,
    # for use in unit tests.
    #
    # @since 1.0.0
    # @provides dummy
    class Dummy < Base
      provides(:dummy)

      def self.default_inversion_options(node, resource)
        super.merge( # Manual overrides for dummy data.
          javascript_binary: ::File.join('', 'node'),
          javascript_environment: nil,
          npm_binary: nil
        )
      end

      # The `install` action for the `javascript_runtime` resource.
      #
      # @return [void]
      def action_install
        # This space left intentionally blank.
      end

      # The `uninstall` action for the `javascript_runtime` resource.
      #
      # @return [void]
      def action_uninstall
        # This space left intentionally blank.
      end

      # Path to the non-existent Javascript.
      #
      # @return [String]
      def javascript_binary
        options['javascript_binary']
      end

      # Environment for the non-existent Javascript.
      #
      # @return [String]
      def javascript_environment
        options['javascript_environment'] || super
      end

      # Path to the non-existent npm.
      #
      # @return [String]
      def npm_binary
        options['npm_binary'] || super
      end
    end
  end
end
