class SessionsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  RpxAuthentication::SessionController
 
  def new
  end
 
  def destroy
    self.current_user = nil
    redirect_to('/')
  end
 
end