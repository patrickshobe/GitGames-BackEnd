require 'gqli'

GITHUB_ACCESS_TOKEN = ENV['github_access_token']
GITHUB_GQL = GQLi::Client.new(
  "https://api.github.com/graphql",
  headers: { "Authorization" => "Bearer #{GITHUB_ACCESS_TOKEN}" }
)
