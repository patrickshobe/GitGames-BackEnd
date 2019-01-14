
class UserQuery
  include QueryHelper

  def self.execute_query(username)
    new.query(username)
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
