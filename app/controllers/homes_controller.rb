require 'net/http'


class HomesController < ApplicationController

  def main
    user_id = session[:user_id]

    @at_home = true
    @categories = [{ temp_url: "homes/new", title: "新着記事", url: "news" }, { temp_url: "homes/fav", title: "おすすめ", url: "recommend" }, { temp_url: "homes/japan", title: "国内サッカー", url: "category/japan" }, { temp_url: "homes/foreign", title: "海外サッカー", url: "category/foreign"}, { temp_url: "homes/japanese", title: "海外日本人", url: "category/japanese"}  ]

    @news = Post.order('date DESC').limit(10) 

    if logged_in?
      responce = JSON.parse(Net::HTTP.get(URI "http://localhost:5000/#{user_id-1}"))
      @indexs = responce[0..10]
    end

    @posts = Post.all

    @foreigns = Post.where("category = 'foreign'").order('date DESC').limit(10)
    @domestics = Post.where("category = 'japan'").order('date DESC').limit(10)
    @japanese = Post.where("category = 'japanese'").order('date DESC').limit(10)

    @slides = []

    if @news[0] != nil 
      @slides.push(@news[0])
    end
    if @foreigns[0] != nil
      @slides.push(@foreigns[0])
    end
    if @domestics[0] != nil
      @slides.push(@domestics[0])
    end

    if @japanese[0]
      @slides.push(@japanese[0])
    end





  end
end
