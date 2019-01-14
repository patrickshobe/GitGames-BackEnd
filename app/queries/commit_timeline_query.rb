class CommitTimelineQuery
  include QueryHelper

  def self.execute_query(username, start_date = nil)
    new.execute(username, start_date)
  end

  def execute(username, start_date = nil)
    return check_for_start_date(username, start_date)
  end

  # decides which query should be executed
  def check_for_start_date(username, start_date)
    return get_with_start_date(username, start_date) if start_date
    return get_basic(username)
  end

  def get_basic(username)
    # check for cached version
    return check_cache(:commit_timeline, username) if check_cache(:commit_timeline, username)

    # Pull new version
    response = default_commit_timeline_query(username)
    save_to_cache(:commit_timeline, username, response)
    return response
  end

  def get_with_start_date(username, start_date)
    # check for cached version
    cached = check_cache("commit_timeline_#{start_date}", username)
    return cached if cached

    # Pull new version
    response = custom_commit_timeline_query(username, format_date(start_date))
    save_to_cache("commit_timeline_#{start_date}", username, response)
    return response
  end


  def format_date(start_date)
    "#{start_date}T00:00:00Z"
  end

  def github_service(query, username)
    validate_response(GithubApiInterface.force_get(query), username)
  end

  def validate_response(response, username)
    return build_failure_response(username) unless response["user"]
    return response
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


end
