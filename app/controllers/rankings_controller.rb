class RankingsController < ApplicationController
  def index
    @posts = Post.order("visit DESC").limit(10)
  end
end
