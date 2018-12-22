class GithubApiInterface

  def initialize
    @github = GQLi::Client.new(
      "https://api.github.com/graphql",
      headers: { "Authorization" => "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}" }
    )
  end

  def execute_query(query)
    @github.execute(query)
  end


  def self.get(query)
    github = new
    github.execute_query(query)
  end
end
