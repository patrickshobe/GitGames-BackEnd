class CommitTimelineQuery

  def self.execute_query(username)
    query = new
    response = query.commit_timeline_query(username)
    return query.build_failure_response(username) unless response["user"]
    return response
  end

  def commit_timeline_query(username)
    github_service(GQLi::DSL.query {
      user(login: "patrickshobe") {
        contributionsCollection {
          contributionCalendar {
            __node("weeks") {
              contributionDays {
                date
                contributionCount
              }
            }
          }
        }
      }
    })
  end

  def github_service(query)
    GithubApiInterface.force_get(query)
  end

  def build_failure_response(username)
    {error: "User #{username} Not Found"}
  end
end
