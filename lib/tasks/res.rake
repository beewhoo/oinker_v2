namespace :res do
  require 'httparty'
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


    while offset < 200

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

      response_json['businesses'].each do |resta|
         @restaurant = Restaurant.find_or_create_by(yelp_id: resta["id"])
         @restaurant.name = resta["name"]
         @restaurant.image_url = resta["image_url"]
         @restaurant.restaurant_url = resta["url"]
         @restaurant.categories_title = resta["categories"].map {|h| h["title"]}
         @restaurant.rating = resta["rating"]
         @restaurant.coordinates_longitude = resta["coordinates"]["longitude"]
         @restaurant.coordinates_latitude = resta["coordinates"]["latitude"]
         @restaurant.price = resta["price"]
         @restaurant.address = resta["location"]["display_address"]
         @restaurant.phone = resta["display_phone"]
         puts "= second call"
         detail_response = HTTP.auth("Bearer #{API_KEY}").get("#{url_details}#{resta['id']}")
         detail_json = detail_response.parse

         if detail_json['hours']
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

       end
       offset += 20
     end

  end




  SEATGEEK_CLIENT_ID=ENV['CLIENT_ID']
  SEATGEEK_HOST='https://api.seatgeek.com/2/events?'
  SEATGEEK_CITY='&venue.city=toronto'
  SEATGEEK_LISTINGS = '&per_page=25'
  SEATGEEK_PRICE='listing_count.gt=0&highest_price.lte=100'


  puts "= Getting the EVENTS"

  url = "#{SEATGEEK_HOST}#{SEATGEEK_PRICE}#{SEATGEEK_CITY}#{SEATGEEK_LISTINGS}&client_id=#{SEATGEEK_CLIENT_ID}"


    response = HTTParty.get(url)
    response_json = JSON.parse(response.body)
    byebug
    puts "= Start Parsing"








end
