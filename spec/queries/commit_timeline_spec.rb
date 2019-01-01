require 'rails_helper'

describe 'Commit Timeline Query' do
  it 'can query user commits over time' do
    VCR.use_cassette('commit_timeline') do
      username = 'patrickshobe'
      response = CommitTimelineQuery.execute_query(username)

      expect(response).to be_a(Hash)
      expect(response).to have_key("user")
      expect(response["user"]).to have_key("contributionsCollection")
      expect(response["user"]["contributionsCollection"]).to have_key("contributionCalendar")
      expect(response["user"]["contributionsCollection"]["contributionCalendar"]).to have_key("weeks")

    end
  end
  it 'can fail to query user commits over time' do
    VCR.use_cassette('commit_timeline_failure') do
      username = 'thishastofailthereisnowaythisis'
      response = CommitTimelineQuery.execute_query(username)

      binding.pry
      expect(response).to be_a(Hash)
      expect(response).to have_key("error")

    end
  end
end
