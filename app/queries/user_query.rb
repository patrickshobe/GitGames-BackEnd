class UserQuery
  def query(username)
   validate_response(username)
  end

  private

  def validate_response(username)
    response = query_maker(username)
    return "User #{username} Not Found" unless response.data.user
    return response.data.user
  end

  def query_maker(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        avatarUrl
        createdAt
        email
        login
        name
      }
    }
    )
  end

  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end
end
