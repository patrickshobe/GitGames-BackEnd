require 'rails_helper'

describe 'Commit Message Query Spec' do
  it 'can query user commit messages' do
    VCR.use_cassette('commit_message') do
      username = 'patrickshobe'
      response = CommitMessageQuery.execute_query(username)


      expect(response).to be_a(Hash)
      expect(response).to have_key("user")
      expect(response["user"]).to have_key("repositories")

    end
  end
end

