# frozen_string_literal: true

describe Github do
  describe '#search' do
    it 'requests and adapts github search response' do
      github_response = JSON.parse(File.read('./spec/github_response.json'))

      github_mock = double('github_client')
      expect(github_mock).to receive(:search_repositories)
        .with('ruby')
        .and_return(github_response)
      github = Github.new(github_mock)

      response = github.search('ruby')

      expect(response).to eq([{ 'name' => 'rails',
                                'description' => 'Ruby on Rails',
                                'url' => 'https://api.github.com/repos/rails/rails' },
                              { 'name' => 'discourse',
                                'description' => 'A platform for community discussion. Free, open, simple.',
                                'url' => 'https://api.github.com/repos/discourse/discourse' },
                              { 'name' => 'gitlabhq',
                                'description' =>
                                   'GitLab CE Mirror | Please open new issues in our issue tracker on GitLab.com',
                                'url' => 'https://api.github.com/repos/gitlabhq/gitlabhq' }])
    end

    it 'return response from api with empty results' do
      query = 'cobol on rails'
      github_response = JSON.parse(File.read('./spec/github_empty_response.json'))

      github_mock = double('github_client')
      expect(github_mock).to receive(:search_repositories).with(query).and_return(github_response)
      github = Github.new(github_mock)

      response = github.search(query)

      expect(response).to eq([])
    end
  end
end
