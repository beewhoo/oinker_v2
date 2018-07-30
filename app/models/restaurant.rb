class Restaurant < ApplicationRecord


  has_many :restaurant_hours
  has_many :users, through: :date_plan
  has_and_belongs_to_many :categories



#rating

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



end
