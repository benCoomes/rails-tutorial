class AddRiderIdToBikes < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :rider_id, :integer
  end
end
