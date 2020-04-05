class RemoveMainContentFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :main_content, :string
  end
end
