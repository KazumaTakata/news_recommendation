class ApplicationController < ActionController::Base
  include SessionsHelper

  def sort_by_date array_var
    tmp = array_var.sort_by &:created_at
    return tmp.reverse[0..10]
  end

  def pegination_path(path , id)
    "#{path}?news_id=#{id}"
  end


  helper_method :pegination_path

end
