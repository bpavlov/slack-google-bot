require 'rubygems'
require 'bundler'

Bundler.setup :default, :development

if ENV['RACK_ENV'] == 'test'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: [:rubocop, :spec]
end
