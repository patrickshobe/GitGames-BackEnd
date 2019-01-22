class RepositoryCountParser
  def get_data(username)
    response = RepositoryCountQuery.execute_query(username)
    return response if response[:error]
    narrow_response(response)
  end

  private

  def narrow_response(response)
    yearly_breakdown(response["repositories"]["nodes"])
  end

  def yearly_breakdown(narrowed_response)
    years = Hash.new(Array.new)
    narrowed_response.each do |repository|
      years[repository["createdAt"].first(4)] += [repository["name"]]
    end
    years
  end
end
