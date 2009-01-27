module RpxAuthentication
  # Holds the rpxnow.com API key
  mattr_accessor :api_key, :user_model
end

# We might constantly get reloaded in development mode.
# In this case we also need to slurp in the config after each reload (mainly to set the API key).
load "#{RAILS_ROOT}/config/initializers/rpx_authentication.rb" if RAILS_ENV == "development"