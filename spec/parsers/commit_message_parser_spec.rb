require 'rails_helper'

describe 'Commit Message Query Spec' do
  it 'can query user commit messages' do
    VCR.use_cassette('commit_message') do
      username = 'patrickshobe'

      message_distribution = CommitMessageParser.new
      message_distribution.get_data(username)

      result = message_distribution.word_count

      expect(result).to be_a(Hash)
      expect(result.length).to be >= 400

    end
  end
end

