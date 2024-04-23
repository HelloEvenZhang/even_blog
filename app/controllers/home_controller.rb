class HomeController < ApplicationController
  def index
    @lastest_posts = Post.order(created_at: :desc).first(4)
  end

  def about
  end
end
