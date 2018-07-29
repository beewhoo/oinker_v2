class Event < ApplicationRecord
    has_many :users, through: :date_plan


    def self.rating
      rating = []
      @events = Event.all
        @events.each do |event|
          if event.price < 50
          rating << event
          end
        end
        return rating.sample(4)
    end


end
