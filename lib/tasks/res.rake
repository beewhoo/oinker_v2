namespace :res do
  desc "TODO"
  task store: :environment do
    API_KEY=ENV['yelp_key']
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_CATEGORY = "restaurants"
    SEARCH_LOCATION = "Toronto"
    SEARCH_PRICE = "1", "2"
    offset = 0
    puts "= Getting the restaurants"

    while offset < 40
    url = "#{API_HOST}#{SEARCH_PATH}"
    url_details = "#{API_HOST}#{BUSINESS_PATH}"
    params = {
      categories: SEARCH_CATEGORY,
      location: SEARCH_LOCATION,
      price: SEARCH_PRICE,
      offset: offset,
    }

      puts "= Offset to #{offset}"
      response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
      response_json = response.parse
      puts "= Start Parsing"

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
         puts "= second call"
         detail_response = HTTP.auth("Bearer #{API_KEY}").get("#{url_details}#{buiz['id']}")
         detail_json = detail_response.parse
         detail_json["hours"].select{|h| h["hours_type"] == "REGULAR"}.first["open"].each do |hour|
           restaurant_hour = @restaurant.restaurant_hours.find_or_create_by(day: hour["day"])
           restaurant_hour.open = hour["start"]
           restaurant_hour.close = hour["end"]
           restaurant_hour.save!
         end
         puts "= Details Parsing"



         @restaurant.save!
         puts "= Restaurant Saved. #{@restaurant.name}"
       end
       offset += 20
     end

  end

end
