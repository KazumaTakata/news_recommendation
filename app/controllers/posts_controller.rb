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
    end

    @post = Post.find(params[:id])
    if @post.visit  
      @post.visit = @post.visit + 1
      @post.save
    else
      @post.visit = 1
      @post.save 
    end


    @counter = @post.visit
    @comments = @post.comments

  end
end
