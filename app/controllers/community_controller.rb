class CommunityController < ApplicationController
  
  before_filter :authenticate_user!
  
  private
    def authenticate_user!
      raise "NotAuthenticated" if session[:user_id].nil? 
    end
  
end
