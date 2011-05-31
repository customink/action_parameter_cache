require 'bundler'
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'

desc 'Default: run unit tests.'
task :default => :spec

desc 'Test the action_parameter_cache gem.'
RSpec::Core::RakeTask.new(:spec)
task :test => :spec
