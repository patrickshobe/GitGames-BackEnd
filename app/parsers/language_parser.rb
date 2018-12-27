class LanguageParser
  attr_reader :languages_breakdown

  def initialize
    @languages_breakdown = Hash.new(0)
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

  end

end
