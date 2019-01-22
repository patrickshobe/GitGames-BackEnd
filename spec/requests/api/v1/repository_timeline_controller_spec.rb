require 'rails_helper'

describe 'Repository Timeline API Endpoints' do
  context 'GET /api/v1/repository_timeline' do
    it 'returns a timeline of the repositories by year' do
      VCR.use_cassette('repository_timeline_controller') do
        username = 'tcraig7'

        get "/api/v1/repository_timeline?username=#{username}"

        expect(response.status).to be(200)

        repositories = JSON.parse(response.body)
require "pry"; binding.pry
        expect(repositories).to have_key("2018")
        expect(repositories).to be_a(Hash)
        expect(repositories["2018"]).to be_a(Array)
      end
    end
  end
end
