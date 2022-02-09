class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destory]
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
    @post = Post.new(
      'author' => params['author'],
      'title'  => params["title"],
      'body'   => params["body"] 
    )
    if @post.save
      redirect_to posts_path
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.set_attributes(
      'author' => params['author'],
      'title'  => params["title"],
      'body'   => params["body"]
    )
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destory
    @post.destory
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params["id"])
  end

end
