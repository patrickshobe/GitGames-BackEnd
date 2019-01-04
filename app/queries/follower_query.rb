class FollowerQuery

  def self.execute_query(username)
    new.query(username)
  end

  def query(username)
   validate_response(username)
  end

  def commit_query(username)
    github_service(GQLi::DSL.query {
                     user(login: username) {
                       followers(first: 100) {
                         nodes {
                         email}
                       }
                     }
    })
  end

  def validate_response(username)
    response = commit_query(username)
    return build_failure_response(username) unless response["user"]
    return response["user"]
  end


  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end

  def build_failure_response(username)
    {error:  "User #{username} Not Found"}
  end
end
