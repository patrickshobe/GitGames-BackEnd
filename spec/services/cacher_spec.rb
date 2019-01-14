require 'rails_helper'

describe 'Cacher Service' do
  it '#build_key' do
    username = 'patrickshobe'
    type = :user
    expected = 'patrickshobe_user'

    cacher = Cacher.new(type, username)
    actual = cacher.build_key

    expect(actual).to eq(expected)
  end
  it '#check_cache' do
    user_1 = 'patrickshobe'
    type = :user
    user_1_value = 'dagnabit!'

    user_2 = 'tcraig7'
    user_2_value = 'sloth!'

    # Store user_1 in cache - skip user_2
    Rails.cache.write("#{user_1}_#{type.to_s}", user_1_value)

    # Validate that user_1 is in the cache and return the data
    cacher = Cacher.new(type, user_1)
    expect(cacher.check_cache).to eq(user_1_value)

    # validaate that user_2 isn't in the cache and return nil
    user_2_cacher = Cacher.new(type, user_2)
    expect(user_2_cacher.check_cache).to eq(nil)
  end
  it '#save_to_cache' do
    username = 'patrickshobe'
    type = :user
    expected = 'dagnabit!'

    cacher = Cacher.new(type, username)
    cacher.save_to_cache(expected)

    actual = Rails.cache.fetch(cacher.build_key)
    expect(actual).to eq(expected)
  end
  it '.find' do
    user_1 = 'patrickshobe'
    type = :user
    user_1_value = 'dagnabit!'

    user_2 = 'tcraig7'
    user_2_value = 'sloth!'

    # Store user_1 in cache - skip user_2
    Rails.cache.write("#{user_1}_#{type.to_s}", user_1_value)

    # Validate that user_1 is in the cache and return the data
    expect(Cacher.find(type, user_1)).to eq(user_1_value)

    # validaate that user_2 isn't in the cache and return nil
    expect(Cacher.find(type, user_2)).to eq(nil)
  end
end
