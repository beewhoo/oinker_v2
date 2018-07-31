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
  end

  # def chosen
  #   @category = params["category"].keys
  #   @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
  # end
  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end


end
