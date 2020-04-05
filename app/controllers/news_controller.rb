class NewsController < ApplicationController
  def index
    @counts = Post.count
    if params[:news_id] == nil 
      @news_id = 1
    else
      @news_id = params[:news_id].to_i
    end

    @news = Post.order('date DESC').limit(10).offset((@news_id-1)*10)
    @path = "news"


  end
end
