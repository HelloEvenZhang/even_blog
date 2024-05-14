class Admin::TagsController < Admin::ApplicationController
  before_action :set_tag, only: %i[ edit update destroy ]

  def index
    @tags = Tag.all.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!

    redirect_to admin_tags_url
  end


  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
