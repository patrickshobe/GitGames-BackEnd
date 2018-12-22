class UserQuery
  def query(username)
    query_maker(username)
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
        followers(first: 10) {
          edges {
            node {
              id
            }
          }
        }
        following(first: 10) {
          edges {
            node {
              id
            }
          }
        }
          }
        }
      )
  end

  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end
end
