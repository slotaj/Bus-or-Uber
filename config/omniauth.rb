Rails.application.config.middleware.use OmniAuth::Builder do
  provider :uber, ENV['uber_client_id'], ENV['uber_client_secret']
end
