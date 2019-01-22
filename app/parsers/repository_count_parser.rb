class RepositoryCountParser
  def initialize
    @repositories_information = []
  end

  def get_data(username)
    response = RepositoryCountQuery.execute_query(username)
    if response[:error]
      @repository_information = response
    else
      narrow_response(response)
    end
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
