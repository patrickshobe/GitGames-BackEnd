class CommitMessageQuery

  def self.execute_query(username)
    query = new
    user = query.get_user_id(username)
    return "User #{username} Not Found" unless user.data.user
    return query.commit_query(username, user)
  end

  def get_user_id(username)
    github_service(GQLi::DSL.query {
                     user(login: username) {
                       id
                     }
    })
  end


  def commit_query(username, user_id)
    github_service(GQLi::DSL.query {
        user(login: username) {
          repositories(last: 100) {
            nodes {
              name
              defaultBranchRef {
                target {
                  __on('Commit') {
                    history(first: 100, author: {id: user_id}) {
                      nodes {
                        message
                      }
                    }
                  }
                }
              }
            }
          }
        }
      })
  end

  def github_service(query)
    GithubApiInterface.get(query)
  end

end
