class AddVisitToCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :visit, :integer
  end
end
