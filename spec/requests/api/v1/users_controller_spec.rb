require 'rails_helper'

describe 'Users API endpoints' do
  context 'GET /api/v1/users/' do
    it 'returns information for one user' do
      VCR.use_cassette('users_controller') do
        username = 'tcraig7'

        get "/api/v1/users?username=#{username}"

        expect(response.status).to be(200)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user).to have_key("avatarUrl")
        expect(user).to have_key("name")
        expect(user).to have_key("login")
        expect(user).to have_key("createdAt")
        expect(user).to have_key("email")
      end
    end
  end
end
