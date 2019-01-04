class MessagingInterface

  def get_emails(username)
    followers = FollowerParser.new
    followers.get_data(username)
  end

  def conn
    Faraday.new(:url => ENV['MESSAGING_SERVICE']) do |f|
      f.adapter  Faraday.default_adapter
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def post(username)
    body = {user: {"emails": get_emails(username),
            "username": username}}.to_json
    conn.post('/api/v1/users') do |req|
      req.body=body
    end
  end

  def self.quick_post(username)
    new.post(username)
  end
end
