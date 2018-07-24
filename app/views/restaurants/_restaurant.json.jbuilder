json.extract! restaurant, :id, :name, :location, :categories, :price, :open_days, :hour_open, :hour_close, :image_url, :address, :phone, :url_restaurant, :rating, :lat, :long, :yelp_id, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
