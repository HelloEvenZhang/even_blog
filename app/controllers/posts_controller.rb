class PostsController < ApplicationController
  before_action :set_post, only: :show

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 4)
  end

  def show
    @seo_title = @post.title
    @seo_keywords = @post.tags.map(&:name).join(", ")
    @seo_description = @post.description
  end

  def search
    if params[:query].present?
      @posts = Post.search_by(params[:query]).paginate(page: params[:page], per_page: 4)
    else
      @posts = Post.paginate(page: params[:page], per_page: 4)
    end

    render "index"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
