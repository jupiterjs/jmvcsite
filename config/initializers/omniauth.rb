require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET']
  provider :open_id, OpenID::Store::Filesystem.new('./tmp')
end