class MessagingInterface

  def get_emails(username)
    followers = FollowerParser.new
    followers.get_data(username)
  end

  def conn
    Faraday.new(:url => ENV['MESSAGING_SERVICE']) do |f|
      f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def post(username)
    conn.post('/api/v1/emails') do |req|
      req.body = {emails: get_emails(username),
                  username: username}.to_json
    end
  end

  def self.quick_post(username)
    new.post(username)
  end
end
