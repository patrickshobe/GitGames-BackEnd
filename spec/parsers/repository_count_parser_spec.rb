require 'rails_helper'

describe 'Repository Count Parser Spec' do
  it '.year_count' do
    VCR.use_cassette('repos_count_parser') do
      username = 'tcraig7'

      repo_count = RepositoryCountParser.new
      repo_count.get_data(username)

      result = repo_count.repository_information

      expect(result).to be_a(Array)
      expect(result[0]).to have_key("year")
      expect(result[0]).to have_key("count")
      expect(result[0]).to have_key("repos")
      expect(result[0]['year']).to be_a(Integer)
      expect(result[0]['count']).to be_a(Integer)
      expect(result[0]['repos']).to be_a(Array)
      expect(result[0]['repos'][0]).to be_a(String)
    end
  end

  it 'can fail to query user repository count' do
    VCR.use_cassette('repository_count_failure') do
      username = 'kjnasdfk;ajnsdfk;ajnsdf'

      repo_count = RepositoryCountParser.new
      repo_count.get_data(username)

      result = repo_count.repository_information

      expect(result).to be_a(Hash)
      expect(result.length).to be(1)
    end
  end
end
