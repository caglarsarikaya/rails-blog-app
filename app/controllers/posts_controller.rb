class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :next_post, :previous_post]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show, :next_post, :previous_post]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @next_posts = Post.where("created_at < ?", @post.created_at)
                     .order(created_at: :desc)
                     .limit(5)
    @previous_post = Post.where("created_at > ?", @post.created_at)
                        .order(created_at: :asc)
                        .first
    @next_post = Post.where("created_at < ?", @post.created_at)
                    .order(created_at: :desc)
                    .first

    respond_to do |format|
      format.html
      format.json {
        render json: {
          post: render_to_string(partial: 'post', formats: [:html], locals: { post: @post }),
          next_posts: render_to_string(partial: 'next_posts', formats: [:html], locals: { next_posts: @next_posts }),
          post_id: @post.id,
          has_next: @next_post.present?,
          has_previous: @previous_post.present?
        }
      }
    end
  end

  def next_post
    @current_post = Post.find(params[:id])
    @post = Post.where("created_at < ?", @current_post.created_at)
                .order(created_at: :desc)
                .first

    if @post
      redirect_to post_path(@post)
    else
      redirect_to posts_path, notice: "No more posts to show."
    end
  end

  def previous_post
    @current_post = Post.find(params[:id])
    @post = Post.where("created_at > ?", @current_post.created_at)
                .order(created_at: :asc)
                .first

    if @post
      redirect_to post_path(@post)
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
    params.require(:post).permit(:title, :content)
  end
end
