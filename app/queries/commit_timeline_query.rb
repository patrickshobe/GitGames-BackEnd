class CommitTimelineQuery
  include QueryHelper

  def self.execute_query(username, start_date = nil)
    new.execute(username, start_date)
  end

  def execute(username, start_date = nil)
    return default_commit_timeline_query(username) unless start_date
    return custom_commit_timeline_query(username, format_date(start_date))
  end

  def format_date(start_date)
    "#{start_date}T00:00:00Z"
  end

  def default_commit_timeline_query(username)
    github_service(GQLi::DSL.query {
      user(login: username) {
        contributionsCollection {
          contributionCalendar {
            __node("weeks") {
              firstDay
              contributionDays {
                date
                contributionCount
              }
            }
          }
        }
      }
    }, username)
  end

  def custom_commit_timeline_query(username, start_date)
    github_service(GQLi::DSL.query {
      user(login: username) {
        contributionsCollection(from: start_date) {
          contributionCalendar {
            __node("weeks") {
              firstDay
              contributionDays {
                date
                contributionCount
              }
            }
          }
        }
      }
    }, username)
  end

  def github_service(query, username)
    validate_response(GithubApiInterface.force_get(query), username)
  end

  def validate_response(response, username)
    return build_failure_response(username) unless response["user"]
    return response
  end
end
