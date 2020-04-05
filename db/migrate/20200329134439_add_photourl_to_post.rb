class AddPhotourlToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :photourl, :text
  end
end
