class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :next_post]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show, :next_post]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @next_posts = Post.where("created_at < ?", @post.created_at)
                     .order(created_at: :desc)
                     .limit(5)
  end

  def next_post
    @current_post = Post.find(params[:id])
    @post = Post.where("created_at < ?", @current_post.created_at)
                .order(created_at: :desc)
                .first

    if @post
      @next_posts = Post.where("created_at < ?", @post.created_at)
                       .order(created_at: :desc)
                       .limit(5)
      render :show
    else
      redirect_to posts_path, notice: "No more posts to show."
    end
  end

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
