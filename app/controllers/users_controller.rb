class UsersController < ApplicationController
  
  def index
    authorize! :read, User
    @users = User.order('name').paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end
