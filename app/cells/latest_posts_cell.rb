class LatestPostsCell < Cell::Rails

  include CanCan::ControllerAdditions
  include CurrentUser
  
  def display
    @posts = Post.accessible_by(current_ability).order('created_at DESC').paginate(:per_page => 5, :page => 1)
    render
  end
  
end
