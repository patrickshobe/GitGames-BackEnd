require 'rails_helper'

describe 'Commit Message API endpoints' do
  context 'GET /api/v1/commit_messages/' do
    it 'returns information for a users commits' do
      VCR.use_cassette('commit_message_request') do
        username = 'patrickshobe'

        get "/api/v1/commit_messages?username=#{username}"

        expect(response.status).to be(200)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body.length).to be >= 400
        expect(body.first[1]).to be_a(Integer)

      end
    end
  end
end
