class LanguageParser
  attr_reader :languages_breakdown,
              :languages_percentages

  def initialize
    @languages_breakdown = Hash.new(0)
    @languages_percentages = Hash.new(0)
  end

  def get_data(username)
    response = LanguageQuery.execute_query(username)
    if response[:error]
      @languages_breakdown = response
    else
      narrow_response(response)
    end
  end

  private

  def narrow_response(response)
    narrowed_response = response["repositories"]["nodes"]
    isolate_nodes(narrowed_response)
  end

  def isolate_nodes(narrowed_response)
    narrowed_response.each do |repo|
      unless repo.languages.edges == []
        repo.languages.edges.each do |language|
          @languages_breakdown[language["node"]["name"]] += language["size"]
        end
      end
    end
    @languages_breakdown
    percentages
  end

  def percentages
    total = @languages_breakdown.values.sum
    @languages_breakdown.each do |name, bytesize|
      @languages_percentages[name] = bytesize.to_f / total
    end
    @languages_percentages
  end
end
