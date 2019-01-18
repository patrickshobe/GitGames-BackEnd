class CommunityQuery
  include QueryHelper

  def self.execute_query(username)
    query = new
    return query.check_cache(:community, username) if query.check_cache(:community, username)
    query.query(username, :community)
  end

  private

  def query_maker(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        followers {
          totalCount
        }
        following {
          totalCount
        }
        starredRepositories {
          totalCount
        }
        repositories {
          totalCount
        }
        repositoriesContributedTo(includeUserRepositories: false) {
          totalCount
        }
        watching {
          totalCount
        }
        issues {
          totalCount
        }
        issueComments {
          totalCount
        }
        pullRequests {
          totalCount
        }
      }
    }
    )
  end

end
