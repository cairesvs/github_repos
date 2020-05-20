# frozen_string_literal: true

require 'json'
require 'faraday'
require 'dotenv'

class GithubClient
  def search_repositories(query)
    connection.get 'search/repositories' do |req|
      req.params[:q] = query
    end
  end

  private

  def connection
    @connection ||= Faraday.new(
        url: url,
        headers: {
            'Content-Type' => 'application/json'
        }
    )
    @connection.options.timeout = ENV['GITHUB_CLIENT_TIMEOUT'].to_f
    @connection.options.open_timeout = ENV['GITHUB_CLIENT_OPEN_TIMEOUT'].to_f
    @connection
  end

  def url
    'https://api.github.com'
  end
end
