require 'rails_helper'

describe 'Commit Message Query Spec' do
  it 'can query user commit messages' do
    VCR.use_cassette('commit_message') do
      username = 'patrickshobe'
      commit_query = CommitMessageQuery.new

      response = commit_query.query(username)

      expect(response).to be_a(GQLi::Response)
      expect(response.data).to_not be nil


    end
  end
end

