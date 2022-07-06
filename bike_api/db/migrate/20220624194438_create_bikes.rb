class CreateBikes < ActiveRecord::Migration[7.0]
  def change
    create_table :bikes do |t|
      t.string :model
      t.integer :year
      t.string :slug
      t.string :description

      t.timestamps
    end
  end
end
