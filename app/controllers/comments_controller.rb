class CommentsController < ApplicationController
  before_action :set_post

  def create
    @post.comments.create! comment_params
    # CommentsMailer.submitted(comment).deliver_later
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:name, :content)
  end
end
