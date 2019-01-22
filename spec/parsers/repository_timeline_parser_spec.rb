require 'rails_helper'

describe 'Repository Timeline Parser Spec' do
  it 'can give a timeline of the repositories by year' do
    VCR.use_cassette('repository_timeline_parser') do
      username = 'tcraig7'

      repo_timeline = RepositoryTimelineParser.new
      result = repo_timeline.get_data(username)

      expect(result).to be_a(Hash)
      expect(result).to have_key("2018")
      expect(result).to have_key("2019")
      expect(result["2018"]).to be_a(Array)
    end
  end

  it 'can fail to query user repository timeline' do
    VCR.use_cassette('repository_timeline_failure') do
      username = 'kjnasdfk;ajnsdfk;ajnsdf'

      repo_timeline = RepositoryTimelineParser.new
      result = repo_timeline.get_data(username)

      expect(result).to be_a(Hash)
      expect(result.length).to be(1)
    end
  end
end
