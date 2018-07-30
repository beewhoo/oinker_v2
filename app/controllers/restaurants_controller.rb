class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!

  # GET /restaurants
  # GET /restaurants.json
  def index
    # @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])
    @show_cat = @restaurant.categories.collect {|cat| cat.category}
    @rest_days_open = @restaurant.restaurant_hours.map {|h| Date::DAYNAMES[h.day - 6]}
    @rest_time_open = @restaurant.restaurant_hours.map {|h| h.open}
    @rest_time_closed = @restaurant.restaurant_hours.map {|h| h.close}
  end

  def chosen
    @category = params["category"].keys
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
  end
  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end


end
