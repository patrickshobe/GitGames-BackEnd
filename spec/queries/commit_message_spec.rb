require 'rails_helper'

describe 'Commit Message Query Spec' do
  it 'can query user commit messages' do
    VCR.use_cassette('commit_message') do
      Rails.cache.clear

      username = 'patrickshobe'
      response = CommitMessageQuery.execute_query(username)


      expect(response).to be_a(Hash)
      expect(response).to have_key("user")
      expect(response["user"]).to have_key("repositories")

    end
  end
  it 'can query user commit messages - cached' do
    VCR.use_cassette('commit_message') do
      username = 'patrickshobe'
      response = CommitMessageQuery.execute_query(username)
      Rails.cache.write("commit_message_patrickshobe", response)
      cached_response = CommitMessageQuery.execute_query(username)


      expect(cached_response).to be_a(Hash)
      expect(cached_response).to have_key("user")
      expect(cached_response["user"]).to have_key("repositories")

    end
  end
end

