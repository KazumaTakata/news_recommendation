class MypagesController < ApplicationController
  def index
    @current_user = current_user
  end

  def edit
  end

  def update
    debugger
    uploaded_file = params["user"]["avatar"]
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end
end
