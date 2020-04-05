class RemoveTimeFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :time, :date
  end
end
