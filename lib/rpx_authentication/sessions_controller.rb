module RpxAuthentication
  # Talks to rpxnow.com to authenticate a user
  module Gateway
    # Needed to talk to rpxnow.com
    include HTTParty
    
    base_uri "rpxnow.com"
    format :json
      
    # Authenticates and returns false or extended profile information
    def self.authenticate(token)
      response = post(
        '/api/v2/auth_info',
        :query => {
          :apiKey => RpxAuthentication.api_key,
          :token => token,
          :extended => "true"
        }
      )
      
      Rails.logger.debug("RPXnow.com says: #{response.inspect} ENDOFRPXRESPONSE")
      return response["profile"] if (response.is_a?(Hash) && response["stat"] == "ok" && response.include?("profile") && !response["profile"]["identifier"].blank?) 
      false
    end
  end
  # Extends the application's SessionsController with standard methods to
  # get started quickly
  module SessionsController
    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end
    end
    
    module InstanceMethods
      def create
        if (params[:token] && profile = RpxAuthentication::Gateway.authenticate(params[:token]))
          unless (user = Object.const_get(RpxAuthentication.user_model).find_by_identifier(profile["identifier"]))
            user = Object.const_get(RpxAuthentication.user_model).create_from_rpx(profile)
          end
          
          log_user_in(user)
          login_successful
        else
          deny_access("Sorry, we couldn't log you in!")
        end
      end
    end
  end
end