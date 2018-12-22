require 'rails_helper'

describe 'User Query Spec' do
  it 'can query user information' do
    VCR.use_cassette('user_query') do
      username = 'tcraig7'
      user_query = UserQuery.new

      response = user_query.query(username)

      expect(response).to have_key("avatarUrl")
      expect(response).to have_key("name")
      expect(response).to have_key("login")
      expect(response).to have_key("createdAt")
      expect(response).to have_key("email")
      expect(response["name"]).to eq("Tara Craig")
    end
  end
end