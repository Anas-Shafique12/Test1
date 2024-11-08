class PostsController < ApplicationController
  # check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  before_action :set_post, only: %i[show edit update destroy toggle_status]

  # GET /posts or /posts.json
  def index
    # Using accessible_by to filter posts based on user permissions
    @posts = Post.accessible_by(current_ability)
    Rails.logger.info("current_ability: #{@posts.inspect}")
    # Use can? to check if the user can read any posts
    if can?(:read, Post)
      @posts = @posts.order(:title).page(params[:page]).per(5)
    else
      redirect_to root_path, alert: "You are not authorized to view posts."
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    # Using authorize! to ensure the user can read this specific post
    authorize! :create, @post
  end

  # GET /posts/new
  def new
    # Only site admins should be able to create new posts
    authorize! :create, Post
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    # Only site admins should be able to edit new posts
    authorize! :edit, @post
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
    authorize! :create, @post  # Check if the user can create a post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # Check if the user can update this specific post
    authorize! :update, @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # Check if the user can destroy this specific post
    authorize! :destroy, @post

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_status
    authorize! :update, @post  # Check if the user can update the post status

    if @post.draft?
      @post.published!
    elsif @post.published?
      @post.draft!
    end
    redirect_to posts_url, notice: "Post status has been updated."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, comments_attributes: [ :content ])
  end
end
