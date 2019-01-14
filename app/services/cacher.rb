class Cacher
  def self.find(type, username)
    new(type, username).check_cache
  end

  def initialize(type, username)
    @type = type
    @username = username
  end

  def check_cache
    Rails.cache.fetch(build_key)
  end

  def save_to_cache(value)
    Rails.cache.write(build_key, value, expires_in: 15.minutes)
  end

  def build_key
    @username + '_' + @type.to_s
  end
end
