module RpxAuthentication
  module ApplicationController
    
    def rpx_iframe
      "<iframe src='https://#{RpxAuthentication.app_name}.rpxnow.com/openid/embed?token_url=#{CGI::escape(auth_complete_url)}'
          scrolling='no' frameBorder='no' style='width:400px;height:240px;'>
      </iframe>"
    end
    
    def rpx_link title = "Sign in"
      "<a class='rpxnow' onclick='return false;'
         href='https://photoalbum.rpxnow.com/openid/v2/signin?token_url=#{CGI::escape(auth_complete_url)}'>
         #{title}
      </a>"
    end
    
    def rpx_javascript
      "<script src='https://rpxnow.com/openid/v2/widget'
              type='text/javascript'></script>
      <script type='text/javascript'>
        RPXNOW.token_url = '#{auth_complete_url}';
        RPXNOW.realm = '#{RpxAuthentication.app_name}';
        RPXNOW.overlay = true;
        RPXNOW.language_preference = 'en';
      </script>"
    end
    
    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end

      base.send :helper_method, :rpx_iframe, :rpx_javascript, :rpx_link if base.respond_to? :helper_method
    end
    
    module InstanceMethods
      def log_user_in(user)
        self.current_user = user
      end
      
      def login_successful
        flash[:notice] = "You're now logged in with the identifier #{h(current_user.identifier)}"
        redirect_back_or_default("/")
      end
      
      def deny_access(message)
        flash[:error] = message
        redirect_to new_session_url
      end      
    end
  end
end