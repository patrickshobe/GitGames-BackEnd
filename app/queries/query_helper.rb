module QueryHelper
  def github_service(query_data)
    GithubApiInterface.get(query_data)
  end

  def query(username)
   validate_response(username)
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
