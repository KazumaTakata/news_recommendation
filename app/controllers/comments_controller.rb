class CommentsController < ApplicationController
  def create
    if params[:comment].length > 0
      Post.find(params[:id]).comments.create({content: params[:comment]})
    end
    redirect_back(fallback_location: root_path)
  end
end
