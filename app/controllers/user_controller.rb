class UserController < ApplicationController

  def show
    load_user
    @date_plans = @user.date_plans
  end

  def destroy
    load_user
    @date_plan = @date_plans.find_by(:id)
    @user.date_plan.find_by(:id)
    redirect_to root
  end



  private

  def load_user
    @user = User.find_by(id: current_user.id)
  end


end
