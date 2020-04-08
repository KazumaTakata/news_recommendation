class AddTitleToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :title, :string
    add_index :posts, :title, unique: true
  end
end
