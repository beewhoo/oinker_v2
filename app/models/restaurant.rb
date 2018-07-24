class Restaurant < ApplicationRecord
  has_many :restaurant_hours
  has_many :users, through: :date_plan


  # #Constants





#Yelp api call



    # def self.details
      # @restaurants = Restaurant.all
      # @restaurants.each do |restaurant|
      #   yelp_id = restaurant.yelp_id
      #   url = "#{API_HOST}#{BUSINESS_PATH}#{yelp_id}"
      #   details_response = HTTP.auth("Bearer #{API_KEY}").get(url)
      #   details_response_json = details_response.parse
      #   restaurant.name = details_response_json["name"]
      #   restaurant.save

      # end

    # end


end
