class CommentsController < ApplicationController
  #filter others: after_action, around_action
  before_action :find_post, only: [:create, :destory]

  def index
    @comments = Comment.all
  end

  def create
    @comment = @post.build_comment(params[:comment])
    
    if @comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
      #default find comments/show so need to specify 
    end
  end

  def destory
    @post.delete_comment(params[:id])

    redirect_to post_path(post.id)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
