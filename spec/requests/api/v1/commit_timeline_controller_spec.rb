require 'rails_helper'

describe 'Commit timeline API endpoints' do
  context 'GET /api/v1/commit_timeline/' do
    it 'returns information for a users commits' do
      VCR.use_cassette('commit_timelines') do
        username = 'patrickshobe'

        get "/api/v1/commit_timelines?username=#{username}"

        expect(response.status).to be(200)

        body = JSON.parse(response.body, symbolize_names: true)


      end
    end
  end
end
