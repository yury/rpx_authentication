require 'rpx_authentication'

config.to_prepare do
  ActionController::Base.send :include, AuthenticatedSystem
  ActionController::Base.send :include, RpxAuthentication::ApplicationController
end