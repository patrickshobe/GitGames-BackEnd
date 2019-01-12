require 'rails_helper'

describe 'Repository Count Spec' do
  it 'can query a count of repositories by year' do
    VCR.use_cassette('repo_count_query') do
      username = 'tcraig7'

      response = RepositoryCountQuery.execute_query(username)

      expect(response[0]).to have_key('year')
      expect(response[0]).to have_key('count')
      expect(response[0]).to have_key('repos')
    end
  end
end
