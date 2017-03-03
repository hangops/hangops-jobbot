require 'kitchen'
require 'net/ssh'
require 'bundler/setup'

# Style tests. Rubocop and Foodcritic
namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: ['~FC064', '~FC065', '~FC007']
    }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
require 'rspec/core/rake_task'
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Tests
namespace :local do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    @config = Kitchen::Config.new(log_level: :info)
    @config.instances.each do |instance|
      instance.test(:passing)
    end
  end
end
namespace :integration do
  desc 'Run Test Kitchen with cloud plugins'
  task :cloud do
    run_kitchen = true
    if run_kitchen
      Kitchen.logger = Kitchen.default_file_logger
      @loader =
        Kitchen::Loader::YAML.new(project_config: './.kitchen.travis.yml')
      config = Kitchen::Config.new(loader: @loader)
      config.instances.each do |instance|
        begin
        instance.test(:passing)
      rescue
        destroy_on_failure = !ENV.fetch('NO_DESTROY_ON_FAILURE', false)
        if destroy_on_failure && instance.last_action.to_s != 'destroy'
          instance.destroy
        end
        raise
      end
      end
    end
  end
end

desc 'Run all tests on Travis CI'
task travis: ['style', 'spec', 'integration:cloud']

# Default
task default: ['style', 'spec', 'local:vagrant']
