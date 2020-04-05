class CategoriesController < ApplicationController
  def index
  end

  def show
    if params[:news_id] == nil 
      @news_id = 1
    else
      @news_id = params[:news_id].to_i
    end
    category = params[:id]
    if category == "japan" or category == "foreign" or category == "japanese"
      @domestics = Post.where("category = '#{category}'").order('date DESC').limit(10).offset((@news_id-1)*10)
      @path = category 
    end

    case category
    when "japan"
      @title = "国内サッカー"
    when "foreign"
      @title = "海外サッカー"
    when "japanese"
      @title = "海外日本人"
    end 
     
  end
end
