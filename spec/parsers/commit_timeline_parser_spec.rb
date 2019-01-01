require 'rails_helper'

describe 'Commit Timeline Parser Spec' do
  it 'Can parse the timeline data' do
    VCR.use_cassette('commit_timeline') do
      username = 'patrickshobe'

      timeline = CommitTimelineParser.new
      result = timeline.get_data(username)

      expect(result).to be_a(Array)
      expect(result.length).to eq(53)
      expect(result.first).to be_a(Hash)
      expect(result.first).to have_key('firstDay')
      expect(result.first).to have_key('contributionDays')
      expect(result.first).to have_key('averageCommits')
      expect(result.first["averageCommits"]).to be_a(Float)
    end
  end
  it 'Can parse the timeline data' do
    VCR.use_cassette('commit_timeline_failure') do
      username = 'notarealusername1234567'

      timeline = CommitTimelineParser.new
      result = timeline.get_data(username)

      expect(result).to be_a(Hash)
      expect(result).to eq({error: "User #{username} Not Found"})
    end
  end
end
