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
    @date_plan.date = Date.strptime(params['date'], '%m/%d/%Y')

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
    @price_max = params['price_max'].to_i
    
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
    @category = params["category"].keys
    list_of_restaurants_matching_days_open(@restaurant_list)
    real_price(@restaurant_list)

    @event_list = Event.all

  end

  private

  def event_list_category(event_list)
    event_list = []
    params[:event_category].each do |category|
      if category == "1"
  end

  def list_of_restaurants_matching_days_open(restaurant_list)
    restaurant_list.each do |restaurant|
       days_open = restaurant.restaurant_hours.map {|h| Date::DAYNAMES[h.day - 6]}
       days_open.each do |day|
         if day == @date.strftime('%A') && restaurant.price.to_i <= @price_max
         next
       else
         restaurant_list.delete('restaurant')
         end
       end
    end
  end

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
