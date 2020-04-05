require 'net/http'
require 'json'

class RecommendsController < ApplicationController
  def index
    user_id = session[:user_id]
    #debugger
    responce = JSON.parse(Net::HTTP.get(URI "http://localhost:5000/#{user_id-1}"))
    @indexs = responce[0..10]
    @posts = Post.all
  end
end
