class UserQuery
  def query(username)
    query_maker(username).data.user
  end

  private

  def query_maker(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        avatarUrl
        name
        login
        createdAt
        email
      }
    }
    )
  end

  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end
end
