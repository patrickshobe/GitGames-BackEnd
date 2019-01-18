require 'rails_helper'

describe 'User Query Spec' do
  it 'can query user information' do
    VCR.use_cassette('community_query') do
      username = 'patrickshobe'


      response = CommunityQuery.execute_query(username)

      expect(response).to have_key("followers")
      expect(response).to have_key("following")
      expect(response).to have_key("starredRepositories")
      expect(response).to have_key("repositories")
      expect(response).to have_key("repositoriesContributedTo")
      expect(response).to have_key("watching")
      expect(response).to have_key("issues")
      expect(response).to have_key("issueComments")
      expect(response).to have_key("pullRequests")
    end
  end

  it 'can return a failure message' do
    VCR.use_cassette('failed_community_query') do
      username = 'notarealusername123494739'
      response = CommunityQuery.execute_query(username)


      expect(response).to eq({error: "User #{username} Not Found"})
    end
  end
end
