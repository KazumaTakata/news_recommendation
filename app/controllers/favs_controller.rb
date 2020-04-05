class FavsController < ApplicationController
  def create
    counter = current_user.counters.find_by({user_id: current_user.id, post_id: params[:id]}) 
    counter.fav = true 
    counter.save
    redirect_back(fallback_location: root_path)
  end


  def index
    counters = current_user.counters.where({fav: true})
    @fav_posts = []
    counters.each do |counter|
      @fav_posts.push(current_user.posts.find(counter.post_id))
    end
  end
end
