require 'date'

class DatePlanController < ApplicationController
  skip_before_action :authenticate_user!

  def plan
    @date = Date.strptime(params['date'], '%m/%d/%Y')
    @quantity = params['quantity']
    @category = params["category"].keys
    @restaurant_list = Restaurant.joins(:categories).where("categories.category" => params["category"].keys)
  end


end
