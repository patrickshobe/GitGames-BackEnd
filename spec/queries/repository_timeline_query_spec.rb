require 'rails_helper'

describe 'Repository Timeline Query Spec' do
  it 'can query a timeline of repositories by year' do
    VCR.use_cassette('repo_timeline_query') do
      username = 'tcraig7'

      response = RepositoryTimelineQuery.execute_query(username)
      actual = response.repositories.nodes[0]

      expect(actual).to have_key('name')
      expect(actual).to have_key('createdAt')
    end
  end

  it 'can return a failure message' do
    VCR.use_cassette('failure_repo_timeline_query') do
      username = 'notarealusername123494739'
      response = RepositoryTimelineQuery.execute_query(username)

      expect(response).to eq({error: "User #{username} Not Found"})
    end
  end
end
