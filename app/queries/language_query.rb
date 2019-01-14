class LanguageQuery
  include QueryHelper

  def self.execute_query(username)
    query = new
    return query.check_cache(:language, username) if query.check_cache(:language, username)
    query.query(username)
  end

  private

  def query_maker(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        repositories(last: 100) {
          nodes {
            name
            languages(last: 10) {
              edges {
                size
                node {
                  name
                }
              }
            }
          }
        }
      }
    })
  end
end
