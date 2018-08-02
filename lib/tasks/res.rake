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


    while offset < 1000

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
         puts "= venue call"
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



      ##seatgeek


        SEATGEEK_CLIENT_ID=ENV['CLIENT_ID']
        SEATGEEK_HOST='https://api.seatgeek.com/2/events?'
        SEATGEEK_CITY='location=toronto'
        SEATGEEK_LISTINGS ='&listing_count.gt=0&per_page=1'
        SEATGEEK_PAGE = '&page=1'
        SEATGEEK_PRICE='&highest_price.lte=200'


        puts "= Getting the EVENTS"

          url = "https://api.seatgeek.com/2/events?venue.city=toronto&client_id=#{SEATGEEK_CLIENT_ID}#{SEATGEEK_LISTINGS}#{SEATGEEK_PRICE}"

          response = HTTParty.get(url)
          response_seat = JSON.parse(response.body)




        response_seat['events'].each do |res|
          @event = Event.find_or_create_by(api_id: res["id"])
          @event.venue = res['venue']['name']
          @event.category= res['type']
          @event.name = res['title']

          @event.date= res['datetime_local']
          @event.url = res['url']
          @event.price = res['stats']['average_price']
          @event.location = res['venue']['address']
          @event.api_id = res['id']
          @event.long = res['venue']['location']['lon']
          @event.lat = res['venue']['location']['lat']

            if res['performers'].first['image'] == nil
              @event.image_url = 'https://d1ic4altzx8ueg.cloudfront.net/finder-us/wp-uploads/2017/08/SeatGeek-featuredimagelogo.jpg'
            else
              @event.image_url = res['performers'].first['image']
            end
          @event.save!
        end




            #Eventbrite

            page_number = 1
            eventbrite_client=ENV['EVENTBRITE_CLIENT_ID']
            url = "https://www.eventbriteapi.com/v3/events/search/?token=#{eventbrite_client}&location.latitude=43.644&location.longitude=-79.409&location.within=50km&price=paid&categories=103,105,104&page=#{page_number}"#103=music #105=performing&visual arts #104film, media entertainment
            response = HTTParty.get(url)



            response_eventbrite = JSON.parse(response.body)
            Event.eventbrite_task(eventbrite_client,response_eventbrite)


          #nextcalls


          while response_eventbrite['pagination']['has_more_items'] == true  && page_number < 7
            page_number +=1
            url = "https://www.eventbriteapi.com/v3/events/search/?token=#{eventbrite_client}&location.latitude=43.644&location.longitude=-79.409&location.within=50km&price=paid&categories=103,105,104&page=#{page_number}"
            response = HTTParty.get(url)
            response_eventbrite = JSON.parse(response.body)
            Event.eventbrite_task(eventbrite_client,response_eventbrite)

          end




    end

end
