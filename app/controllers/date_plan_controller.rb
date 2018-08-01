require 'date'

class DatePlanController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @date_plan = DatePlan.new
  end

  def create
    @date_plan = DatePlan.new
    @date_plan.restaurant_id = params["restaurant"]
    @date_plan.user_id = current_user.id
    @date_plan.date = params["date"]

    if @date_plan.save
      redirect_to user_url(current_user.id)
    else
      flash[:notice] = "You have to select a restaurant to save your date plan!"
      redirect_back fallback_location: @post
    end
  end

  def plan
    @date = Date.strptime(params['date'], '%m/%d/%Y')
    @quantity = params['quantity'].to_i
    @category = params["category"].keys
    @price_max = params['price_max'].to_i
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
    real_price(@restaurant_list)
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
