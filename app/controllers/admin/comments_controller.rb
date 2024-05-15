class Admin::CommentsController < Admin::ApplicationController
  before_action :set_post, only: %i[index]
  before_action :set_comment, only: %i[destroy]

  def index
    @comments = @post.comments.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @comment.destroy!

    redirect_to admin_post_comments_url
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
