class TagCloudCell < Cell::Rails

  include CanCan::ControllerAdditions
   include CurrentUser

  def display
    @tags = Post.accessible_by(current_ability).tag_counts_on(:tags)
    render
  end
  
end
