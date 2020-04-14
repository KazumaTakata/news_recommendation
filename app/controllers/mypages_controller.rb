require 'digest/sha1'


class MypagesController < ApplicationController
  def index
    @current_user = current_user
  end

  def edit
  end

  def update
    if params["user"] != nil
      uploaded_file = params["user"]["avatar"]
      file_name = uploaded_file.original_filename.split "."
      file_name = (Digest::SHA1.hexdigest file_name[0]) + "." + file_name[1]
      File.open(Rails.root.join('app', 'assets', 'images' ,file_name), 'wb') do |file|
        file.write(uploaded_file.read)
      end

      user = current_user
      user.img = file_name
      user.save
    end

    if params["user_name"] != ""
      user = current_user
      user.name = params["user_name"]
      user.save
    end

    render "index"

  end
end
