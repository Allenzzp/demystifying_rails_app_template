class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @post = Post.find(params["post_id"])
    @comment = @post.build_comment(
      'author' => params["author"],
      'body'   => params["body"]
    )
    if @comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
    end
  end

  def destory
    post = Post.find(params["post_id"])
    post.delete_comment(params["id"])

    redirect_to post_path(post.id)
  end



end
