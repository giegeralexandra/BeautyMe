
Rails.application.config.middleware.use OmniAuth::Builder do
    configure do |config|
        config.path_prefix = '/auth'
      end
    provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
