class CommitMessageQuery
  include QueryHelper

  def self.execute_query(username)
    query = new
    if query.check_cache(:commit_message, username).nil?
      user = query.get_user_id(username)
      return query.check_failure(user, username)
    else
      return query.check_cache(:commit_message, username)
    end
  end

  def check_failure(user, username)
    unless user["user"]
      response = build_failure_response(username)
    else
      response = commit_query(username, user["user"]["id"])
    end
    save_to_cache(:commit_message, username, response)
    response
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
end
