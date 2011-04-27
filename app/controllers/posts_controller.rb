class PostsController < CommunityController
  
  skip_before_filter :authenticate_user!
  
  before_filter :authenticate_user!, :except => [:index, :show, :tag, :user, :bucket]
  
  # GET /posts
  # GET /posts.xml
  def index
    authorize! :read, Post
    @posts = Post.accessible_by(current_ability).order('created_at DESC').paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.rss { render :layout => false } 
    end
  end

  def bucket
    authorize! :read, Post
    @bucket = Bucket.find_by_slug params[:bucket]
    raise ActiveRecord::RecordNotFound if @bucket.nil?
    @posts = get_posts_from_bucket(@bucket)
    render :action => 'index'
  end
  
  def tag
    authorize! :read, Post
    @bucket = {:name => "Tagged with #{params[:tag]}", :tags => [params[:tag]]}
    @posts = get_posts_from_bucket(@bucket)
    render :action => 'index'
  end
  
  def user
    authorize! :read, Post
    user = User.find params['user_id']
    @posts = user.posts
                 .accessible_by(current_ability)
                 .order('created_at DESC')
                 .paginate(:per_page => 15, :page => params[:page])
    @has_posts = " from #{user.name}"
    @no_posts = " from #{user.name}"
    render :action => 'index'
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    
    @post = Post.find(params[:id])
    
    authorize! :read, @post
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    authorize! :write, Post
    @post = current_user.posts.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.xml
  def create
    authorize! :write, Post
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    authorize! :edit, Post
    respond_to do |format|
      is_approved = params[:post].delete(:is_approved)
      if current_user.is_admin? and !is_approved.nil?
        @post.is_approved = is_approved
      end
      
      if @post.update_attributes(params[:post]) 
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
        format.json { render :json => @post}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def get_posts_from_bucket(bucket)
      @no_posts = "tagged with #{bucket[:tags].to_sentence(:two_words_connector => ' or ', :last_word_connector => ' or ')}"
      @has_posts = " tagged with <b>#{@bucket[:tags].to_sentence(:two_words_connector => ' or ', :last_word_connector => ' or ')}</b>"
      Post.accessible_by(current_ability).tagged_with(bucket[:tags], :any => true).paginate(:per_page => 15, :page => params[:page], :order => 'created_at DESC')
    end
  
end
