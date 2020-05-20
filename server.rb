# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/custom_logger'
require 'ougai'
require 'dotenv'
require './config/application'
require './controllers/github'

class Server < Sinatra::Base
  helpers Sinatra::CustomLogger
  Dotenv.load

  configure :development do
    register Sinatra::Reloader
    ApplicationConfig.logger.level = Ougai::Logger::DEBUG
    set :logger, ApplicationConfig.logger
  end

  configure :production do
    set :logger, ApplicationConfig.logger
  end

  # Dependencies
  github_client = GithubClient.new
  logger.info('Server UP')

  # Routes
  get '/' do
    @resp = Github.new(github_client).search(params['q'])
    erb :index
  end
end
