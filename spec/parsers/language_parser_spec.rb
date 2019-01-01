require 'rails_helper'

describe 'Language Query Parser Spec' do
  it 'can parse language query info' do
    VCR.use_cassette('language_parser_happy') do
      username = 'tcraig7'

      parsed_language = LanguageParser.new
      parsed_language.get_data(username)

      result = parsed_language.languages_breakdown

      expect(result.overall).to be_a(Hash)
      expect(result.overall).to have_key("Ruby")
      expect(result.overall).to have_key("CSS")
      expect(result.overall["Ruby"]).to be_a(Integer)
    end
  end

  it 'can parse language query info' do
    VCR.use_cassette('language_parser_happy_2') do
      username = 'tcraig7'

      parsed_language = LanguageParser.new
      parsed_language.get_data(username)

      result = parsed_language.languages_percentages

      expect(result).to be_a(Hash)
      expect(result).to have_key("Ruby")
      expect(result).to have_key("CSS")
      expect(result["Ruby"]).to be_a(Float)
    end
  end

  it 'can fail to query user languages' do
    VCR.use_cassette('language_query_sad') do
      username = 'kjnasdfk;ajnsdfk;ajnsdf'

      parsed_language = LanguageParser.new
      parsed_language.get_data(username)

      result = parsed_language.languages_percentages

      expect(result).to be_a(Hash)
      expect(result.length).to be(1)
    end
  end
end
