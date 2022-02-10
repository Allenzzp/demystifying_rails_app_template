class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
          # mass assignment
    @post = Post.new(params[:post])

    if @post.save
      redirect_to posts_path
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.set_attributes(params[:post])
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

end

#access params property value (2 ways)
  #["key"] string 
  #[:key]  symbol