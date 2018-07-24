class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :categories
      t.string :price
      t.string :open_days
      t.string :hour_open
      t.string :hour_close
      t.string :image_url
      t.string :address
      t.string :phone
      t.string :url_restaurant
      t.decimal :rating
      t.decimal :lat
      t.decimal :long
      t.string :yelp_id

      t.timestamps
    end
  end
end
