class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.all.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!

    redirect_to admin_posts_url
  end

  def search
    if params[:query].present?
      @posts = Post.search_by(params[:query]).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.paginate(page: params[:page], per_page: 10)
    end

    render "index"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :description, :background_img, tag_ids: [])
  end
end
