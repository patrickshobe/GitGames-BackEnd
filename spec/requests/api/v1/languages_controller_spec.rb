require 'rails_helper'

describe 'Languages API endpoints' do
  context 'GET /api/v1/languages/' do
    it 'returns language percentages for a user' do
      VCR.use_cassette('languages_controller') do
        username = 'tcraig7'

        get "/api/v1/languages?username=#{username}"

        expect(response.status).to be(200)

        languages = JSON.parse(response.body, symbolize_names: true)

        expect(languages). to have_key("Ruby")
        expect(languages). to have_key("CSS")
        expect(languages["Ruby"]). to be_a(Float)
      end
    end
  end
end
