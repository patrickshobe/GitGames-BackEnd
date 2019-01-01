class GithubApiInterface

  def initialize
    @github = GQLi::Client.new(
      "https://api.github.com/graphql",
      headers: { "Authorization" => "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}" }
    )
  end

  def execute_query(query)
    result = @github.execute(query)
    strip_result(result)
  end

  def force_execute_query(query)
    result = @github.execute!(query)
    strip_result(result)
  end

  def strip_result(result)
    result.data
  end

  def self.get(query)
    github = new
    github.execute_query(query)
  end

  def self.force_get(query)
    github = new
    github.force_execute_query(query)
  end
end
