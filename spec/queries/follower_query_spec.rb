require 'rails_helper'

describe 'User Follower Query' do
  it 'should return followers' do
    VCR.use_cassette('follower_query') do
      username = 'patrickshobe'

      response = FollowerQuery.execute_query(username)

      expect(response).to be_a(Hash)
      expect(response).to have_key('followers')
      expect(response['followers']['nodes']).to be_a(Array)
    end
  end
  it 'should fail to return followers' do
    VCR.use_cassette('follower_query_failure') do
      username = 'notarealusername1234567'

      response = FollowerQuery.execute_query(username)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:error)
      expect(response).to eq({error: "User #{username} Not Found"})
    end

  end
end
