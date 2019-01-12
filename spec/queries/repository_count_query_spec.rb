require 'rails_helper'

describe 'Repository Count Spec' do
  it 'can query a count of repositories by year' do
    VCR.use_cassette('repo_count_query') do
      username = 'tcraig7'

      response = RepositoryCountQuery.execute_query(username)
      actual = response.repositories.nodes[0]

      expect(actual).to have_key('name')
      expect(actual).to have_key('createdAt')
    end
  end

  it 'can return a failure message' do
    VCR.use_cassette('failure_repo_count_query') do
      username = 'notarealusername123494739'
      response = UserQuery.execute_query(username)

      expect(response).to eq({error: "User #{username} Not Found"})
    end
  end
end
