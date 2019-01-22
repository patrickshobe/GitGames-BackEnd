require 'rails_helper'

describe 'Language Query' do
  it 'can query user languages information' do
    VCR.use_cassette('language_query') do
      Rails.cache.clear

      username = 'tcraig7'

      response = LanguageQuery.execute_query(username)
      response_breakdown = response["repositories"]["nodes"][0]
      response_breakdown_cont = response_breakdown["languages"]["edges"][0]

      expect(response).to have_key("repositories")
      expect(response_breakdown).to have_key("languages")
      expect(response_breakdown).to have_key("name")
      expect(response_breakdown_cont).to have_key("size")
      expect(response_breakdown_cont["node"]).to have_key("name")
    end
  end
  it 'can query user languages information - cached' do
    VCR.use_cassette('language_query') do
      username = 'tcraig7'

      initial_response = LanguageQuery.execute_query(username)
      Rails.cache.write("tcraig7_language", initial_response)
      response = LanguageQuery.execute_query(username)
      response_breakdown = response["repositories"]["nodes"][0]
      response_breakdown_cont = response_breakdown["languages"]["edges"][0]

      expect(response).to have_key("repositories")
      expect(response_breakdown).to have_key("languages")
      expect(response_breakdown).to have_key("name")
      expect(response_breakdown_cont).to have_key("size")
      expect(response_breakdown_cont["node"]).to have_key("name")
    end
  end
end
