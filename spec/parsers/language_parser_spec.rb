require 'rails_helper'

describe 'Language Query Parser Spec' do
  it '.languages_breakdown' do
    VCR.use_cassette('language_parser_happy') do
      username = 'tcraig7'

      parsed_language = LanguageParser.new
      parsed_language.get_data(username)

      result = parsed_language.languages_breakdown

      expect(result).to be_a(Hash)
      expect(result).to have_key("Ruby")
      expect(result).to have_key("CSS")
      expect(result["Ruby"]).to be_a(Integer)
    end
  end

  it '.languages_percentages' do
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

  it '.user_percentages' do
    VCR.use_cassette('language_parser_happy_3') do
      username = 'tcraig7'

      parsed_language = LanguageParser.new
      parsed_language.get_data(username)

      result = parsed_language.user_percentages

      expect(result).to have_key("Overall")
      expect(result).to have_key("Repositories")
      expect(result["Overall"]).to be_a(Hash)
      expect(result["Overall"]).to have_key("Ruby")
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
