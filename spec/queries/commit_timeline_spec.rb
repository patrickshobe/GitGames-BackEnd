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
      username = 'notarealusername1234567'
      response = CommitTimelineQuery.execute_query(username)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:error)
      expect(response).to eq({error: "User #{username} Not Found"})

    end
  end
  it 'can query user commits over time with start date' do
    VCR.use_cassette('commit_timeline_start') do
      username = 'patrickshobe'
      initial_response = CommitTimelineQuery.execute_query(username, '2018-06-01')
      Rails.cache.write("patrickshobe_commit_timeline_2018-06-01", initial_response)
      response = CommitTimelineQuery.execute_query(username, '2018-06-01')

      expect(response).to be_a(Hash)
      expect(response).to have_key("user")
      expect(response["user"]).to have_key("contributionsCollection")
      expect(response["user"]["contributionsCollection"]).to have_key("contributionCalendar")
      expect(response["user"]["contributionsCollection"]["contributionCalendar"]).to have_key("weeks")
    end
  end
end
