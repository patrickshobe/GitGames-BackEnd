class LanguageParser
  attr_reader :languages_breakdown,
              :languages_percentages,
              :user_percentages

  def initialize
    @languages_breakdown = Hash.new(0)
    @languages_percentages = Hash.new(0)
    @repo_percentages = []
    @user_percentages = Hash.new(0)
  end

  def get_data(username)
    response = LanguageQuery.execute_query(username)
    if response[:error]
      @languages_percentages = response
    else
      narrow_response(response)
    end
    @user_percentages
  end

  private

  def narrow_response(response)
    narrowed_response = response["repositories"]["nodes"]
    isolate_nodes(narrowed_response)
  end

  def isolate_nodes(narrowed_response)
    narrowed_response.each do |repo|
      unless repo.languages.edges == []
        overall_percentages(repo)
        repository_percentages(repo)
      end
    end
  end

  def overall_percentages(repo)
    repo.languages.edges.each do |language|
      @languages_breakdown[language["node"]["name"]] += language["size"]
    end
    @languages_breakdown
    total_percentages
  end

  def total_percentages
    total = @languages_breakdown.values.sum
    @languages_breakdown.each do |name, bytesize|
      @languages_percentages[name] = bytesize.to_f / total
    end
    @user_percentages["Overall"] = @languages_percentages
  end

  def repository_percentages(repo)
    repo_languages = Hash.new(0)
    repo.languages.edges.each do |language|
      repo_languages[language["node"]["name"]] += language["size"]
    end
    total_repo_percentages(repo_languages)
    repo_languages["name"] = repo["name"]
    @repo_percentages << repo_languages
    @user_percentages["Repositories"] = @repo_percentages
  end

  def total_repo_percentages(repo_languages)
    total = repo_languages.values.sum
    repo_languages.map do |name, bytesize|
      repo_languages[name] = bytesize.to_f / total
    end
  end
end
