class User < ActiveRecord::Base
  include RpxAuthentication::UserModel
end