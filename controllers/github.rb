# frozen_string_literal: true

require_relative '../requests/github_client'

class Github
  ERR_GENERIC = 'Failed to fetch data from github, try again later.'

  def initialize(github_client)
    @github_client = github_client
  end

  def search(query)
    if query
      begin
        adapt_response(@github_client.search_repositories(query))
      rescue Faraday::TimeoutError, Faraday::ConnectionFailed
        ApplicationConfig.logger.error 'Error fetching data from github repositories'
        adapt_error_response(ERR_GENERIC)
      end
    end
  end

  private

  def adapt_error_response(error_message)
    {
      items: [],
      error: error_message
    }
  end

  def adapt_response(response)
    adapted = {}
    if response.status == 403
      ApplicationConfig.logger.error 'Rate limit exceed'
      adapted = adapt_error_response(ERR_GENERIC)
    else
      m = JSON.parse(response.body)
      items = m['items'].map do |item|
        {
          name: item['name'],
          description: item['description'],
          url: item['html_url']
        }
      end
      adapted = {
        items: items
      }
    end
    adapted
  end
end
