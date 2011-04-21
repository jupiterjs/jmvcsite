class LatestPostsCell < Cell::Rails

  def display
    @posts = Post.order('created_at DESC').paginate(:per_page => 5, :page => 1)
    render
  end

end
