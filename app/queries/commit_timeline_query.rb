class CommitTimelineQuery
  include QueryHelper

  def self.execute_query(username, start_date = nil)
    new.execute(username, start_date)
  end

  def execute(username, start_date = nil)
    return check_for_start_date(username, start_date)
  end

  def check_for_start_date(username, start_date)
    if start_date
      response = get_with_start_date(username, start_date)
    else
      response = get_basic(username)
    end
    return response
  end

  def get_basic(username)
    if check_cache(:commit_timeline, username)
      response = check_cache(:commit_timeline, username)
    else
      response = default_commit_timeline_query(username)
      save_to_cache(:commit_timeline,
                    username,
                    response)
    end
    return response
  end

  def get_with_start_date(username, start_date)
    if check_cache("commit_timeline_#{start_date}", username)
      response = check_cache("commit_timeline_#{start_date}", username)
    else
      response = custom_commit_timeline_query(username, format_date(start_date))
      save_to_cache("commit_timeline_#{start_date}",
                    username,
                    response)
    end
    return response
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
