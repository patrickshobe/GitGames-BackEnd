class FollowerQuery
  include QueryHelper

  def self.execute_query(username)
    query = new
    return query.check_cache(:follower, username) if query.check_cache(:follower, username)
    query.query(username, :follower)
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
