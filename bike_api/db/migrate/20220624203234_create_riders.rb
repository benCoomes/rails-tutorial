class CreateRiders < ActiveRecord::Migration[7.0]
  def change
    create_table :riders do |t|
      t.string :name
      t.integer :age
      t.integer :races_won

      t.timestamps
    end
  end
end
