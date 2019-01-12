class RepositoryCountQuery
  def self.execute_query(username)
    new.query(username)
  end

  def query(username)
    validate_response(username)
  end

  private

  def validate_response(username)
    response = query_maker(username)
    return build_failure_response(username) unless response["user"]
    return response["user"]
  end

  def query_maker(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        repositories(last: 100) {
          nodes {
            name
            createdAt
          }
        }
      }
    })
  end

  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end

  def build_failure_response(username)
    {error: "User #{username} Not Found"}
  end
end
