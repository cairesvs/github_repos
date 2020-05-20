# frozen_string_literal: true

task :run do
  sh 'rackup config.ru'
end

namespace :docker do
  task :build do
    sh 'docker build -t github_repos .'
  end

  task :run do
    sh 'docker run -p 3000:3000 github_repos'
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end
