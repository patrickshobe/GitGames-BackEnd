class LanguageQuery
  def self.execute_query(username)
    new.query(username)
  end

  def query(username)
    validate_response(username)
  end

  private

  def validate_response(username)
    response = make_query(username)
    return build_failure_response(username) if response["user"].nil?
    return response["user"]
  end

  def make_query(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        repositories(last: 100) {
          nodes {
            name
            languages(last: 10) {
              edges {
                size
                node {
                  name
                }
              }
            }
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
