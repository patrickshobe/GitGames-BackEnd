class UserQuery
  include QueryHelper

  def self.execute_query(username)
    query = new
    return query.check_cache(:user, username) if query.check_cache(:user, username)
    query.query(username, :user)
  end

  private

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

end
