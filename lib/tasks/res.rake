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



 puts '--------------------------Seatgeek----------------------------------'


        SEATGEEK_CLIENT_ID=ENV['CLIENT_ID']
        SEATGEEK_HOST='https://api.seatgeek.com/2/events?'
        SEATGEEK_CITY='location=toronto'
        SEATGEEK_LISTINGS ='&listing_count.gt=0&per_page=200'
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


        puts '------------------Eventbrite------------------------'

            url = 'https://www.eventbriteapi.com/v3/events/search/?token=X23FKITQCHRKGAKADTU4&location.latitude=43.644&location.longitude=-79.409&location.within=50km'
            response = HTTParty.get(url)
            response_eventbrite = JSON.parse(response.body)

            response_eventbrite['events'].each do |event|

              #edge-cases

              if event['is_free'] == true
                next
              end
              if event['online_event'] == true
                next
              end


            url_second = "https://www.eventbriteapi.com/v3/venues/#{event['venue_id']}/?token=X23FKITQCHRKGAKADTU4"
            response_second_call = HTTParty.get(url_second)

            url_third = "https://www.eventbriteapi.com/v3/categories/#{event['category_id']}/?token=X23FKITQCHRKGAKADTU4"
            response_third_call = HTTParty.get(url_third)

            url_fourth = "https://www.eventbriteapi.com/v3/events/#{event['id']}/ticket_classes/?token=X23FKITQCHRKGAKADTU4"
            response_fourth_call = HTTParty.get(url_fourth)

            @event = Event.find_or_create_by(api_id: event["id"])

            #edge case & fourth call

              if response_fourth_call['ticket_classes'].last['cost']
                @event.price = response_fourth_call['ticket_classes'].last['cost']['major_value'].to_i
              end

            #edge case & first call

              if event['logo'] == nil || event['logo']['url'] == nil
                @event.image_url = 'https://cdn.business2community.com/wp-content/uploads/2013/08/eventbrite_logo2-300x300.jpg'
              else
                @event.image_url = event['logo']['url']
              end

            #third call
            @event.category = response_third_call['short_name']

            #second call
            @event.location = response_second_call['address']['localized_address_display']
            @event.long = response_second_call['longitude']
            @event.lat = response_second_call['latitude']
            @event.venue = response_second_call['name']

            #first call
            @event.name = event['name']['text']
            @event.url = event['url']
            @event.date = event['start']['local']

            #save
            @event.save

                puts "NAME#{@event.name}"
                puts "PRICE#{@event.price}"
                puts "LOCATION#{@event.location}"
                puts "CATEGORY#{@event.category}"
                puts "VENUE#{@event.venue}"
          end

    end

end
