class AddFavToCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :fav, :bool
  end
end
