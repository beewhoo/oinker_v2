class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :image_url
      t.string :restaurant_url
      t.text :categories_title, array:true, default: []
      t.decimal :rating
      t.string :coordinates_longitude
      t.string :coordinates_latitude
      t.string :price
      t.text :address, array:true, default: []
      t.string :phone
      t.string :yelp_id

      t.timestamps
    end
  end
end
