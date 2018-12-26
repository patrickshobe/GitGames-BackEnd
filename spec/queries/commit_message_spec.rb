require 'rails_helper'

describe 'Commit Message Query Spec' do
  it 'can query user commit messages' do
    VCR.use_cassette('commit_message') do
      username = 'patrickshobe'
      commit_query = CommitMessageQuery.new

      response = commit_query.query(username)

      first_result = response.data.user.repositories.nodes.first
      first_result_data = first_result.defaultBranchRef.target.history.nodes

      expect(first_result).to have_key("name")
      expect(first_result).to have_key("defaultBranchRef")
      expect(first_result_data.first).to have_key("message")

    end
  end
end

