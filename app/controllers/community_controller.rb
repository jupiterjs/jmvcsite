class CommunityController < ApplicationController
  
  before_filter :authenticate_user!
  
end
