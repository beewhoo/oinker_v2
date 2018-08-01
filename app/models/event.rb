class Event < ApplicationRecord
    has_many :users, through: :date_plan

    def self.rating
      rating = []
      @events = Event.all
        @events.each do |event|
          if event.price.to_i < 50
          rating << event
          end
        end
        return rating.sample(4)
    end



    def self.eventbrite_task(eventbrite_client,response_eventbrite)
      response_eventbrite['events'].each do |event|

      @event = Event.find_or_create_by(api_id: event["id"])
            #edge-cases first-call
            if event['online_event'] == true
              next
            end

            if event['logo'] == nil || event['logo']['url'] == nil
              @event.image_url = 'https://cdn.business2community.com/wp-content/uploads/2013/08/eventbrite_logo2-300x300.jpg'
            else
              @event.image_url = event['logo']['url']
            end

          puts '------------------Venue eventbrite call------------------------'
          url_venue = "https://www.eventbriteapi.com/v3/venues/#{event['venue_id']}/?token=#{eventbrite_client}"
          response_venue_call = HTTParty.get(url_venue)

          puts '------------------Price eventbrite call------------------------'

          url_price = "https://www.eventbriteapi.com/v3/events/#{event['id']}/ticket_classes/?token=#{eventbrite_client}"
          response_price_call = HTTParty.get(url_price)

          #edge case for price call
          if response_price_call['ticket_classes'].first['cost']
            @event.price = response_price_call['ticket_classes'].first['cost']['major_value'].to_i
          end

          if event['category_id'] == '103'
             @event.category = 'music'
          elsif  event['category_id'] =='105'
             @event.category = 'art'
          elsif event['category_id'] == '104'
            @event.category = 'entertainment'
          end

          #venue call
          @event.location = response_venue_call['address']['localized_address_display']
          @event.long = response_venue_call['longitude']
          @event.lat = response_venue_call['latitude']
          @event.venue = response_venue_call['name']

          #first call
          @event.name = event['name']['text']
          @event.url = event['url']
          @event.date = event['start']['local']

          #save event
          @event.save
        end
    end

end
