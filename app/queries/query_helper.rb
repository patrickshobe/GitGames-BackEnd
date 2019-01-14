module QueryHelper
  def check_cache(type, username)
    Cacher.find(type, username)
  end

  def save_to_cache(type, username, response)
    Cacher.save(type, username, response)
  end

  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end

  def query(username, type = nil)
   response = validate_response(username)
   save_to_cache(type, username, response)
   response
  end

  def validate_response(username)
    response = query_maker(username)
    return build_failure_response(username) unless response["user"]
    return response["user"]
  end

  def build_failure_response(username)
    {error:  "User #{username} Not Found"}
  end
end
