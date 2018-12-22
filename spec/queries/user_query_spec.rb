require 'rails_helper'

describe 'User Query Spec' do
  it 'can query user information' do
    VCR.use_cassette('user_query') do
      username = 'tcraig7'
      user_query = UserQuery.new

      response = user_query.query(username)

      expect(response.data.user).to have_key("avatarUrl")
      expect(response.data.user).to have_key("name")
      expect(response.data.user).to have_key("login")
      expect(response.data.user).to have_key("createdAt")
      expect(response.data.user).to have_key("email")
      expect(response.data.user).to have_key("followers")
      expect(response.data.user).to have_key("following")
      expect(response.data.user["name"]).to eq("Tara Craig")
    end
  end
end
