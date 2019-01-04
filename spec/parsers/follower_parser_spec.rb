require 'rails_helper'

describe 'Follwoer Parser' do
  it 'should return an array of followers' do
    VCR.use_cassette('follower_query') do
      username = 'patrickshobe'

      follower_parser = FollowerParser.new
      result = follower_parser.get_data(username)

      expect(result).to be_a(Array)
      expect(result.length).to be > 1
    end
  end
end
