class AddTimeToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :time, :date
  end
end
