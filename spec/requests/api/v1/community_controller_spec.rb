require 'rails_helper'

describe 'Community API endpoints' do
  context 'GET /api/v1/community/' do
    it 'returns information for one user' do
      VCR.use_cassette('community_controller') do
        username = 'patrickshobe'

        get "/api/v1/community?username=#{username}"

        expect(response.status).to be(200)

        community_data = JSON.parse(response.body, symbolize_names: true)

        expect(community_data).to have_key(:followers)
        expect(community_data).to have_key(:following)
        expect(community_data).to have_key(:starredRepositories)
        expect(community_data).to have_key(:repositories)
        expect(community_data).to have_key(:repositoriesContributedTo)
        expect(community_data).to have_key(:watching)
        expect(community_data).to have_key(:issues)
        expect(community_data).to have_key(:issueComments)
        expect(community_data).to have_key(:pullRequests)
      end
    end
  end
end
