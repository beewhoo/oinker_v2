require 'date'

class DatePlanController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @date_plan = DatePlan.new
  end

  def show
    load_user
    @date_plan = @user.date_plans.find(params[:id])
  end


  def create
    @date_plan = DatePlan.new
    @date_plan.restaurant_id = params["restaurant"]
    @date_plan.user_id = current_user.id
    @date_plan.date = Date.strptime(params['date'], '%m/%d/%Y')
    @date_plan.event_id = params["event"]

    if @date_plan.save
      redirect_to show_date_plan_url(@date_plan)
    else
      flash[:notice] = "You have to select a restaurant to save your date plan!"
      redirect_back fallback_location: @post
    end
  end

  def destroy
    @date_plan = DatePlan.find(params[:id])
    @date_plan.destroy
    redirect_to user_path
  end


  def plan
    @new_list = []
    @date = Date.strptime(params['date'], '%m/%d/%Y')
    @quantity = params['quantity'].to_i
    @price_max = params['price_max'].to_i
    @price_max_for_quantity = @quantity * @price_max

    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
    @category = params["category"].keys
    @event_list = Event.where("category in (?)", event_filter_categories)


    list_of_restaurants_matching_days_open(@restaurant_list)
    real_price(@restaurant_list)

    event_list_price(@event_list, @restaurant_list)
    @new_list = @new_list.sample(3)

  end

  private

  def event_filter_categories
    categories = params[:event_category].select do |key, value|
      value == "1"
    end
    return categories.keys
  end

  def list_of_restaurants_matching_days_open(restaurant_list)
    restaurant_list = restaurant_list.all.select do |restaurant|
       days_open = restaurant.restaurant_hours.map {|h| Date::DAYNAMES[h.day - 6]}
       list_days_open = days_open.select do |day|
         day == @date.strftime('%A')
       end
       list_days_open.length > 0
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

  def event_list_price(event_list, restaurant_list)
    event_list.each do |event|
      restaurant_list.each do |restaurant|
        if event.price.to_i + restaurant.price.to_i <= @price_max
         @new_list.push([event, restaurant])
        end
      end
    end
  end

  def load_user
    @user = User.find_by(id: current_user.id)
  end


end
