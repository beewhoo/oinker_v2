require 'date'

class DatePlanController < ApplicationController
  skip_before_action :authenticate_user!

  def plan
    @date_plan = DatePlan.new
    @date = Date.strptime(params['date'], '%m/%d/%Y')
    @quantity = params['quantity'].to_i
    @category = params["category"].keys
    @price_max = params['price_max'].to_i
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
    real_price(@restaurant_list)
    console
  end

  private

  def real_price(list)
    list.each do |restaurant|
      if restaurant.price == '$'
        restaurant.price = 15
      elsif restaurant.price == '$$'
        restaurant.price = 30
      end
    end
  end

end
