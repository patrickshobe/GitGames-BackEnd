class CommitMessageQuery

  def query(username)
    user_id = get_user_id(username).data.user.id
    data = commit_query(username, user_id)
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
          repositories(last: 10) {
            nodes {
              name
              defaultBranchRef {
                target {
                  __on('Commit') {
                    history(first: 10, author: {id: user_id}) {
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
