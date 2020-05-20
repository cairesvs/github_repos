require_relative '../requests/github_client'

class Github
  def initialize(github_client)
    @github_client = github_client
  end

  def search(query)
    if query
      begin
        response = @github_client.search_repositories(query)
        adapt_response(response)
      rescue Faraday::TimeoutError
        ApplicationConfig.logger.error 'Error fetching data from github repositories'
        []
      end
    end
  end

  private

  def adapt_response(hash_map)
    hash_map['items'].map do |item|
      item.slice('name', 'description', 'url')
    end
  end
end
