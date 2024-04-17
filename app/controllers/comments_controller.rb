class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new comment_params

    respond_to do |format|
      if @comment.save
        cookies[:commenter_name] = @comment.name
        Turbo::StreamsChannel.broadcast_update_later_to(:comment_create, target: "comments", partial: "posts/comments", locals: { post: @post })
        format.turbo_stream
      else
        format.html { redirect_to @post }
      end
    end
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
