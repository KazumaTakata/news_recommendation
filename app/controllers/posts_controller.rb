class PostsController < ApplicationController
  def show

    if current_user 
      if current_user.counters.exists?({user_id: current_user.id, post_id: params[:id]})
        counter = current_user.counters.find_by({user_id: current_user.id, post_id: params[:id]}) 
        counter.visit = counter.visit + 1
        counter.save
      else
        current_user.counters.create({user_id: current_user.id, post_id: params[:id], visit: 1}) 
      end
    else
      post = Post.find(params[:id])
      if post.visit  
        post.visit = post.visit + 1
        post.save
      else
        post.visit = 1
        post.save 
      end
    end 

    post = Post.find(params[:id])
    @counter = 0

    post.counters.each { |counter|
      @counter += counter.visit
    }

    if post.visit
      @counter += post.visit
    end 

    @post = Post.find(params[:id])
  end
end
