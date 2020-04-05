class AddMainContentToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :main_content, :text
  end
end
