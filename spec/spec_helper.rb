require 'rack/test'
require 'rspec'

require 'sinatra'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'server')
require File.join(File.dirname(__FILE__), '..', 'controllers/github')
require File.join(File.dirname(__FILE__), '..', 'requests/github_client')

module RSpecMixin
  include Rack::Test::Methods

  def app()
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
