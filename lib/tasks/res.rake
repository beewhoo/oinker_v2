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


    while offset < 1

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

      # see from our list of categories if the restaurant has those categories


      response_json['businesses'].each do |resta|
         @restaurant = Restaurant.find_or_create_by(yelp_id: resta["id"])
         our_categories = Category.all
         our_categories.each do |category|
           resta["categories"].each do |h|
             if h["title"] == category.category
               @restaurant.categories << category
             end
           end
         end

         # remove restaurant from list of restaurants if the categories is empty
         # move onto the next restaurant
         if @restaurant.categories.empty?
           @restaurant.destroy
           next
         end

         @restaurant.name = resta["name"]
         @restaurant.image_url = resta["image_url"]
         @restaurant.restaurant_url = resta["url"]
         @restaurant.rating = resta["rating"]
         @restaurant.coordinates_longitude = resta["coordinates"]["longitude"]
         @restaurant.coordinates_latitude = resta["coordinates"]["latitude"]
         @restaurant.price = resta["price"]
         @restaurant.address = resta["location"]["display_address"].join(', ')
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

           # check the categories from API results, compare to

           puts "= Restaurant Saved. #{@restaurant.name}"
        end

       end
       offset += 20
     end



 #events --------------------------Seatgeek----------------------------------events


        SEATGEEK_CLIENT_ID=ENV['CLIENT_ID']
        SEATGEEK_HOST='https://api.seatgeek.com/2/events?'
        SEATGEEK_CITY='q=toronto'
        SEATGEEK_LISTINGS ='&per_page=1'
        SEATGEEK_PAGE = '&page=1'
        SEATGEEK_PRICE='&highest_price.lte=2'


        puts "= Getting the EVENTS"

          url = "https://api.seatgeek.com/2/events?q=toronto&client_id=#{SEATGEEK_CLIENT_ID}#{SEATGEEK_LISTINGS}#{SEATGEEK_PRICE}"

          response = HTTParty.get(url)
          response_seat = JSON.parse(response.body)
          # byebu


        response_seat['events'].each do |res|
          @event = Event.find_or_create_by(seatgeek_id: res["id"])
          @event.venue = res['venue']['name']
          @event.category= res['type']
          @event.name = res['title']

          @event.date= res['datetime_local']
          @event.url = res['url']
          @event.price = res['stats']['average_price']
          @event.location = res['venue']['address']
          @event.seatgeek_id = res['id']
          @event.long = res['venue']['location']['lat']
          @event.lat = res['venue']['location']['lat']
          @event.save!
        end


        #event------------------Eventbrite------------------------_#event
        puts "= Getting into second EVENTS"



    end

end
