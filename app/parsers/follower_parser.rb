class FollowerParser

  def get_data(username)
    response = FollowerQuery.execute_query(username)
    return response if response[:error]
    narrow_response(response)
  end

  def narrow_response(response)
    isolate_emails(response['followers']['nodes'])
  end

  def isolate_emails(response)
    response.map do | response_hash |
      response_hash['email'] unless response_hash['email'].empty?
    end.compact
  end
end
