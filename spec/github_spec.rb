# frozen_string_literal: true

class MockResponse
  attr_accessor :body, :status
end

describe Github do
  describe '#search' do
    it 'requests and adapts github search response' do
      query = 'ruby'
      github_response = MockResponse.new
      github_response.body = File.read('./spec/github_response.json')
      github_response.status = 200

      github_mock = double('github_client')
      expect(github_mock).to receive(:search_repositories)
                                 .with('ruby')
                                 .and_return(github_response)
      github = Github.new(github_mock)

      response = github.search(query)

      expect(response).to eq({
                                 items: [{name: 'rails',
                                          description: 'Ruby on Rails',
                                          url: 'https://github.com/rails/rails'},
                                         {name: 'discourse',
                                          description: 'A platform for community discussion. Free, open, simple.',
                                          url: 'https://github.com/discourse/discourse'},
                                         {name: 'gitlabhq',
                                          description:
                                              'GitLab CE Mirror | Please open new issues in our issue tracker on GitLab.com',
                                          url: 'https://github.com/gitlabhq/gitlabhq'}]
                             })
    end

    it 'return response from api with empty results' do
      query = 'cobol on rails'
      github_response = MockResponse.new
      github_response.body = File.read('./spec/github_empty_response.json')
      github_response.status = 200

      github_mock = double('github_client')
      expect(github_mock).to receive(:search_repositories)
                                 .with(query)
                                 .and_return(github_response)
      github = Github.new(github_mock)

      response = github.search(query)

      expect(response).to eq({
                                 items: []
                             })
    end

    it 'should return empty items for rate limited and an error' do
      query = 'cobol on rails'
      github_response = MockResponse.new
      github_response.body = File.read('./spec/github_rate_limit_exceed.json')
      github_response.status = 403

      github_mock = double('github_client')
      expect(github_mock).to receive(:search_repositories)
                                 .with(query)
                                 .and_return(github_response)
      github = Github.new(github_mock)

      response = github.search(query)

      expect(response).to eq({
                                 items: [],
                                 error: 'Failed to fetch data from github, try again later.'
                             })
    end
  end
end
