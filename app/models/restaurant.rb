class Restaurant < ApplicationRecord
  has_many :restaurant_hours
  has_many :users, through: :date_plan
  has_and_belongs_to_many :categories





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

  def blank_stars
    5 - rating.to_i
  end

end
