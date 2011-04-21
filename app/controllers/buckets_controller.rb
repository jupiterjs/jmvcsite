class BucketsController < CommunityController
  
  skip_before_filter :authenticate_user!
  
  def show
    @bucket = Bucket.find_by_slug params[:slug]
    raise ActiveRecord::RecordNotFound if @bucket.nil?
    @posts = Post.tagged_with(@bucket[:tags], :any => true).paginate(:per_page => 15, :page => params[:page], :order => 'created_at DESC')
  end
  
  def by_tag
    @bucket = {:name => "Tagged with #{params[:tag]}", :tags => [params[:tag]]}
    @posts = Post.tagged_with(@bucket[:tags], :any => true).paginate(:per_page => 15, :page => params[:page], :order => 'created_at DESC')
    render :action => 'show'
  end
  
end
