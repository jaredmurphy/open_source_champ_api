Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :github, ENV['OPEN_SOURCE_API_GITHUB_CLIENT_ID'], ENV['OPEN_SOURCE_API_GITHUB_CLIENT_SECRET']
end
