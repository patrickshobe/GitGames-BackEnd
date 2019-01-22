require 'rails_helper'

describe 'Repository Count Parser Spec' do
  it '.year_count' do
    VCR.use_cassette('repos_count_parser') do
      username = 'tcraig7'

      repo_count = RepositoryCountParser.new
      result = repo_count.get_data(username)

      expect(result).to be_a(Hash)
      expect(result).to have_key("2018")
      expect(result).to have_key("2019")
      expect(result["2018"]).to be_a(Array)
    end
  end

  it 'can fail to query user repository count' do
    VCR.use_cassette('repository_count_failure') do
      username = 'kjnasdfk;ajnsdfk;ajnsdf'

      repo_count = RepositoryCountParser.new
      result = repo_count.get_data(username)

      expect(result).to be_a(Hash)
      expect(result.length).to be(1)
    end
  end
end
