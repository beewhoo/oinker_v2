class Restaurant < ApplicationRecord
  has_many :restaurant_hours
  has_many :users, through: :date_plan






  def self.rating
    rating = []
    @restaurants = Restaurant.all
      @restaurants.each do |resta|
        if resta.rating.to_f > 4
        rating << resta
        end
      end
      return rating.sample(8)
  end





end
