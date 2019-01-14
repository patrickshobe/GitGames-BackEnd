class FollowerQuery
  include QueryHelper

  def self.execute_query(username)
    new.query(username)
  end

  def query_maker(username)
    github_service(GQLi::DSL.query {
                     user(login: username) {
                       followers(first: 100) {
                         nodes {
                         email}
                       }
                     }
    })
  end

end
