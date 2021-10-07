# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc 'Start a console session with xml_sanitizer gem loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'xml_sanitizer'

  ARGV.clear
  IRB.start
end
