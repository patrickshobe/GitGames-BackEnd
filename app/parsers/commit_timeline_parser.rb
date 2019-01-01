class CommitTimelineParser

  def get_data(username)
    response = CommitTimelineQuery.execute_query(username)
    validate_response(response)
  end

  def isolate_weeks(response)
    narrowed = response["user"]["contributionsCollection"]["contributionCalendar"]["weeks"]
    calculate_averages(narrowed)
  end

  def validate_response(response)
    if response[:error]
      return response
    else
      return averages(response)
    end
  end

  def averages(response)
    isolate_weeks(response)
  end

  def calculate_averages(weeks)
    weeks.each do | week |
      week["averageCommits"] = (week_sum(week["contributionDays"]) / 7.0)
    end
  end

  def week_sum(contributions)
    contributions.inject(0) do |sum, contribution|
      sum += contribution["contributionCount"]
    end
  end
end

