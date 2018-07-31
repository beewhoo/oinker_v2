require 'date'

class DatePlanController < ApplicationController
  skip_before_action :authenticate_user!

  def plan
    @date_plan = DatePlan.new
    @date = Date.strptime(params['date'], '%m/%d/%Y')
    @quantity = params['quantity']
    @category = params["category"].keys
    @price_max = params['price_max']
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
    @restaurant_hours = restaurant.restaurant_hours.map {|h| Date::DAYNAMES[h.day - 6]}
  end

  private

  def real_price(list)
    list = Restaurant.all
    list.each do |restaurant|
      if restaurant.price == '$'
        restaurant.price = 15
      elsif restaurant.price == '$$'
        restaurant.price = 30
      end
    end
  end

end
