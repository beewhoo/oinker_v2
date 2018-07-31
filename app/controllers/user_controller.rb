class UserController < ApplicationController

  def show
    @user = User.find_by(id: current_user.id)
    @date_plans = @user.date_plans
  end




end
