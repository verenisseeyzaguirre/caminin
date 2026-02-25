class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listing = :all
    @posts = Post.includes(:user).order(created_at: :desc)
    @posts = @posts.where(tag: params[:tag]) if params[:tag].present?
  end

  def mine
    @listing = :mine
    @posts = current_user.posts.order(created_at: :desc)
    @posts = @posts.where(tag: params[:tag]) if params[:tag].present?
    render :index
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post creado 🌱"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post eliminado"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tag)
  end
end
