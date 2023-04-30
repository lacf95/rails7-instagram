class PostsController < ApplicationController
  before_action :validates_user_session
  before_action :validates_ownership, only: %i[edit update destroy]

  def index
    @posts = Post.where(user: current_user.followeds.to_a << current_user)
  end

  def show
    post
  end

  def new
    @post = Post.new
  end

  def edit
    post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to action: :show, id: @post.id
    else
      render :new
    end
  end

  def update
    if post.update(post_params)
      redirect_to action: :show, id: post.id
    else
      render :edit
    end
  end

  def destroy
    post.destroy
    redirect_to action: :index
  end

  private

  def post
    @post ||= Post.where(user: current_user.followeds.to_a << current_user).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :description)
  end

  def validates_ownership
    return if current_user == post.user

    head 404
  end
end
