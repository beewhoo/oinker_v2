class Restaurant < ApplicationRecord


  has_many :restaurant_hours
  has_many :users, through: :date_plan
  has_and_belongs_to_many :categories


  def self.rating
    rating = []
    @restaurants = Restaurant.all
      @restaurants.each do |resta|
        if resta.rating.to_f > 3.5
        rating << resta
        end
      end
      return rating.sample(4)
  end

  # def self.new_price(@restaurant_list)
  #   @restaurants_list.each do |restaurant|
  #     if restaurant.price == '$'
  #       restaurant.price = 10
  #     elsif restaurant.price == '$$'
  #       restaurant.price = 30
  #     end
  #   end
  # end

  def blank_stars
    5 - rating.to_i
  end




end
