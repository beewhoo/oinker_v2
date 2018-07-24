class CreateRestaurantHours < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_hours do |t|
      t.integer :day
      t.string :open
      t.string :close
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
