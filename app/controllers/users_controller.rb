class UsersController < ApplicationController
  
  def index
    authorize! :read, User
    @users = User.order('name').paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def update
    @user = User.find(params[:id])
    authorize! :edit, User
    respond_to do |format|
      is_admin = params[:user].delete(:is_admin)
      if current_user.is_admin? and !is_admin.nil?
        @user.is_admin = is_admin
      end
      
      if @user.update_attributes(params[:user]) 
        format.json { render :json => @user}
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
