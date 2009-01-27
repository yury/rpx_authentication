module RpxAuthentication
  # Holds the rpxnow.com API key
  mattr_accessor :api_key, :user_model, :app_name, :lang

end

# We might constantly get reloaded in development mode.
# In this case we also need to slurp in the config after each reload (mainly to set the API key).
if RAILS_ENV == "development" 
  config = "#{RAILS_ROOT}/config/initializers/rpx_authentication.rb"
  load config if File.exist? config
end