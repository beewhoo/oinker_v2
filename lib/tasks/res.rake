namespace :res do
  desc "TODO"
  task store: :environment do
    API_KEY="NhddQRDNcF1ul0wnKMH4vfElRMW3Ype3NjAOAvBwbK6K7NYxPzOPqnGPy_4SC2m0OtFqLzwF5FefK0MDYkPaq3-YHzeGg5lA0N1594-_E7sFhwxZFfxGPstLar5UW3Yx"
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_CATEGORY = "restaurants"
    SEARCH_LOCATION = "Toronto"
    SEARCH_PRICE = "1", "2"
    offset = 0
    puts "= Getting the restaurants"

    while offset < 1000
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      categories: SEARCH_CATEGORY,
      location: SEARCH_LOCATION,
      price: SEARCH_PRICE,
      offset: offset,
    }

      puts "= Offset to #{offset}"
      response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
      response_json = response.parse
      puts "= Start Prasing"

      response_json['businesses'].each do |buiz|
         @restaurant = Restaurant.find_or_create_by(yelp_id: buiz["id"])
         @restaurant.name = buiz["name"]
         @restaurant.image_url = buiz["image_url"]
         @restaurant.restaurant_url = buiz["url"]
         @restaurant.categories_title = buiz["categories"].map {|h| h["title"]}
         @restaurant.rating = buiz["rating"]
         @restaurant.coordinates_longitude = buiz["coordinates"]["longitude"]
         @restaurant.coordinates_latitude = buiz["coordinates"]["latitude"]
         @restaurant.price = buiz["price"]
         @restaurant.address = buiz["location"]["display_address"]
         @restaurant.phone = buiz["display_phone"]
         @restaurant.save!
         puts "= Restaurant Saved. #{@restaurant.name}"
       end
       offset += 20
     end

  end

end
