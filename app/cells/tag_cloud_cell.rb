class TagCloudCell < Cell::Rails

  def display
    @tags = Post.tag_counts_on(:tags)
    render
  end

end
