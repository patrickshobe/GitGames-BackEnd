require 'rails_helper'

describe 'Commit timeline API endpoints' do
  context 'GET /api/v1/commit_timeline/' do
    it 'returns information for a users commits' do
      VCR.use_cassette('commit_timelines') do
        username = 'patrickshobe'

        get "/api/v1/commit_timelines?username=#{username}"

        expect(response.status).to be(200)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Array)
        expect(body.first).to be_a(Hash)
        expect(body.first).to have_key(:firstDay)
        expect(body.first).to have_key(:contributionDays)
        expect(body.first).to have_key(:averageCommits)
        expect(body.first[:contributionDays]).to be_a(Array)
        expect(body.first[:contributionDays].first).to have_key(:date)
        expect(body.first[:contributionDays].first).to have_key(:contributionCount)
        expect(body.first[:contributionDays].first[:date]).to be_a(String)
        expect(body.first[:contributionDays].first[:contributionCount]).to be_a(Integer)
      end
    end
    it 'returns information for a users commits with a start date' do
      VCR.use_cassette('commit_timelines_custom') do
        username = 'patrickshobe'
        start_date = "2018-09-01"

        get "/api/v1/commit_timelines?username=#{username}&startDate=#{start_date}"

        expect(response.status).to be(200)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Array)
        expect(body.first).to be_a(Hash)
        expect(body.first).to have_key(:firstDay)
        expect(body.first).to have_key(:contributionDays)
        expect(body.first).to have_key(:averageCommits)
        expect(body.first[:contributionDays]).to be_a(Array)
        expect(body.first[:contributionDays].first).to have_key(:date)
        expect(body.first[:contributionDays].first).to have_key(:contributionCount)
        expect(body.first[:contributionDays].first[:date]).to be_a(String)
        expect(body.first[:contributionDays].first[:contributionCount]).to be_a(Integer)

        expect(body.last[:averageCommits]).to eq(0.0)
      end
    end
  end
end
