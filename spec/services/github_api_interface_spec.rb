require 'rails_helper'

describe 'Github API Interface' do
  it 'should make a successful get' do
    VCR.use_cassette('github_api_service') do
    	query = GQLi::DSL.query { user(login: "tcraig7") {
                      createdAt
                      name }}


    	response = GithubApiInterface.get(query)

			expect(response.data.user.keys).to eq(["createdAt", "name"])
			expect(response.data.user["name"]).to eq("Tara Craig")

    end
  end
end
